import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import '../objects/Workout.dart';
import '../objects/WorkoutSet.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._internal();

  factory DatabaseManager() => instance;

  DatabaseManager._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      return await openDatabase(
        'ironlog.db',
        version: 2,
        onCreate: _createDB,
        onUpgrade: _upgradeDB,
      );
    } else {
      if (Platform.isLinux || Platform.isWindows) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'ironlog.db');

      return await openDatabase(
        path,
        version: 2,
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
        onCreate: _createDB,
        onUpgrade: _upgradeDB,
      );
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date TEXT NOT NULL,
        completed INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE workout_sets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workout_id INTEGER NOT NULL,
        exercise_name TEXT NOT NULL,
        set_number INTEGER NOT NULL,
        weight REAL NOT NULL,
        reps INTEGER NOT NULL,
        FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    await db.execute('DELETE FROM workout_sets;');
    await db.execute('DELETE FROM workouts;');
  }

  Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    final map = workout.toMap();
    if (map['id'] == null) {
      map.remove('id');
    }
    return await db.insert(
      'workouts',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> completeWorkout(int workoutId) async {
    final db = await database;
    await db.update(
      'workouts',
      {'completed': 1},
      where: 'id = ?',
      whereArgs: [workoutId],
    );
  }

  Future<int> insertSet(WorkoutSet workoutSet) async {
    final db = await database;
    final map = workoutSet.toMap();
    if (map['id'] == null) {
      map.remove('id');
    }
    return await db.insert(
      'workout_sets',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'workouts',
      orderBy: 'id DESC',
    );
    return maps.map((map) => Workout.fromMap(map)).toList();
  }

  Future<List<WorkoutSet>> getSetsForWorkout(int workoutId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'workout_sets',
      where: 'workout_id = ?',
      whereArgs: [workoutId],
      orderBy: 'set_number ASC',
    );
    return maps.map((map) => WorkoutSet.fromMap(map)).toList();
  }

  Future<Map<String, double>> getPersonalRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT exercise_name, MAX(weight) as max_weight
      FROM workout_sets
      GROUP BY exercise_name
    ''');

    final Map<String, double> records = {};
    for (final row in result) {
      final exerciseName = row['exercise_name'] as String?;
      final maxWeight = row['max_weight'] as num?;
      if (exerciseName != null && maxWeight != null) {
        records[exerciseName] = maxWeight.toDouble();
      }
    }
    return records;
  }
}
