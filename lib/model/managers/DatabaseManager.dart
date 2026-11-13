import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import '../objects/PlannedExercise.dart';
import '../objects/Workout.dart';
import '../objects/WorkoutSet.dart';
import '../support/Constants.dart';

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
        Constants.dbName,
        version: 3,
        onCreate: _createDB,
        onUpgrade: _upgradeDB,
      );
    } else {
      if (Platform.isLinux || Platform.isWindows) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }

      final dbPath = await getDatabasesPath();
      final path = join(dbPath, Constants.dbName);

      return await openDatabase(
        path,
        version: 3,
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
      CREATE TABLE IF NOT EXISTS ${Constants.tableWorkouts} (
        ${Constants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constants.colWorkoutName} TEXT NOT NULL,
        ${Constants.colWorkoutDate} TEXT NOT NULL,
        ${Constants.colWorkoutCompleted} INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${Constants.tableWorkoutSets} (
        ${Constants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constants.colSetWorkoutId} INTEGER NOT NULL,
        ${Constants.colSetExerciseName} TEXT NOT NULL,
        ${Constants.colSetNumber} INTEGER NOT NULL,
        ${Constants.colSetWeight} REAL NOT NULL,
        ${Constants.colSetReps} INTEGER NOT NULL,
        FOREIGN KEY (${Constants.colSetWorkoutId}) REFERENCES ${Constants.tableWorkouts}(${Constants.colId}) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${Constants.tablePlannedExercises} (
        ${Constants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constants.colPlannedDayOfWeek} INTEGER,
        ${Constants.colPlannedSplitName} TEXT,
        ${Constants.colPlannedExerciseName} TEXT,
        ${Constants.colPlannedTargetSets} INTEGER,
        ${Constants.colPlannedTargetReps} INTEGER,
        ${Constants.colPlannedRestSeconds} INTEGER
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${Constants.tablePlannedExercises} (
        ${Constants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Constants.colPlannedDayOfWeek} INTEGER,
        ${Constants.colPlannedSplitName} TEXT,
        ${Constants.colPlannedExerciseName} TEXT,
        ${Constants.colPlannedTargetSets} INTEGER,
        ${Constants.colPlannedTargetReps} INTEGER,
        ${Constants.colPlannedRestSeconds} INTEGER
      )
    ''');
  }

  Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    final map = workout.toMap();
    if (map[Constants.colId] == null) {
      map.remove(Constants.colId);
    }
    return await db.insert(
      Constants.tableWorkouts,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> completeWorkout(int workoutId) async {
    final db = await database;
    await db.update(
      Constants.tableWorkouts,
      {Constants.colWorkoutCompleted: 1},
      where: '${Constants.colId} = ?',
      whereArgs: [workoutId],
    );
  }

  Future<int> insertSet(WorkoutSet workoutSet) async {
    final db = await database;
    final map = workoutSet.toMap();
    if (map[Constants.colId] == null) {
      map.remove(Constants.colId);
    }
    return await db.insert(
      Constants.tableWorkoutSets,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      Constants.tableWorkouts,
      orderBy: '${Constants.colId} DESC',
    );
    return maps.map((map) => Workout.fromMap(map)).toList();
  }

  Future<List<WorkoutSet>> getSetsForWorkout(int workoutId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      Constants.tableWorkoutSets,
      where: '${Constants.colSetWorkoutId} = ?',
      whereArgs: [workoutId],
      orderBy: '${Constants.colSetNumber} ASC',
    );
    return maps.map((map) => WorkoutSet.fromMap(map)).toList();
  }

  Future<Map<String, double>> getPersonalRecords() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT ${Constants.colSetExerciseName}, MAX(${Constants.colSetWeight}) as ${Constants.colMaxWeightAlias}
      FROM ${Constants.tableWorkoutSets}
      GROUP BY ${Constants.colSetExerciseName}
    ''');

    final Map<String, double> records = {};
    for (final row in result) {
      final exerciseName = row[Constants.colSetExerciseName] as String?;
      final maxWeight = row[Constants.colMaxWeightAlias] as num?;
      if (exerciseName != null && maxWeight != null) {
        records[exerciseName] = maxWeight.toDouble();
      }
    }
    return records;
  }

  Future<int> insertPlannedExercise(PlannedExercise ex) async {
    final db = await database;
    final map = ex.toMap();
    if (map[Constants.colId] == null) {
      map.remove(Constants.colId);
    }
    return await db.insert(
      Constants.tablePlannedExercises,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deletePlannedExercise(int id) async {
    final db = await database;
    await db.delete(
      Constants.tablePlannedExercises,
      where: '${Constants.colId} = ?',
      whereArgs: [id],
    );
  }

  Future<List<PlannedExercise>> getPlannedExercisesForDay(int dayOfWeek) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      Constants.tablePlannedExercises,
      where: '${Constants.colPlannedDayOfWeek} = ?',
      whereArgs: [dayOfWeek],
      orderBy: '${Constants.colId} ASC',
    );
    return maps.map((map) => PlannedExercise.fromMap(map)).toList();
  }
}
