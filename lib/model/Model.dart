import 'package:flutter/foundation.dart';

import 'managers/DatabaseManager.dart';
import 'objects/PlannedExercise.dart';
import 'objects/Workout.dart';
import 'objects/WorkoutSet.dart';
import 'support/Constants.dart';

class Model extends ChangeNotifier {
  static final Model _instance = Model._internal();
  static Model get sharedInstance => _instance;
  static Model get instance => _instance;

  factory Model() => _instance;

  Model._internal();

  final DatabaseManager _dbManager = DatabaseManager();

  List<Workout> workouts = [];
  Workout? activeWorkout;
  List<WorkoutSet> currentSets = [];
  Map<String, double> personalRecords = {};

  List<PlannedExercise> plannedExercisesForSelectedDay = [];
  int selectedDayOfWeek = DateTime.now().weekday;
  int currentTabIndex = Constants.tabHome;

  bool get isEmpty =>
      workouts.isEmpty &&
      personalRecords.isEmpty &&
      plannedExercisesForSelectedDay.isEmpty;

  /// Calcola la percentuale di completamento del workout odierno (0.0 - 100.0).
  double get todayWorkoutCompletionPercentage {
    if (plannedExercisesForSelectedDay.isEmpty) {
      return 0.0;
    }

    final int totalTargetSets = plannedExercisesForSelectedDay.fold<int>(
      0,
      (sum, ex) => sum + ex.targetSets,
    );

    if (totalTargetSets <= 0) {
      return 0.0;
    }

    final String today = DateTime.now().toIso8601String().split('T').first;
    final bool hasCompletedWorkoutToday = workouts.any(
      (w) => w.date == today && w.completed,
    );

    if (hasCompletedWorkoutToday && activeWorkout == null) {
      return 100.0;
    }

    final int completedSetsCount = currentSets.length;
    final double percentage = (completedSetsCount / totalTargetSets) * 100.0;
    return percentage.clamp(0.0, 100.0);
  }

  double get workoutCompletionPercentage => todayWorkoutCompletionPercentage;

  Future<void> initModel() async {
    workouts = await _dbManager.getWorkouts();
    personalRecords = await _dbManager.getPersonalRecords();
    plannedExercisesForSelectedDay =
        await _dbManager.getPlannedExercisesForDay(selectedDayOfWeek);
    notifyListeners();
  }

  void setTabIndex(int index) {
    if (currentTabIndex == index) return;
    currentTabIndex = index;
    notifyListeners();
  }

  Future<void> selectDayOfWeek(int dayOfWeek) async {
    selectedDayOfWeek = dayOfWeek;
    plannedExercisesForSelectedDay =
        await _dbManager.getPlannedExercisesForDay(selectedDayOfWeek);
    notifyListeners();
  }

  Future<void> setSelectedDay(int dayOfWeek) => selectDayOfWeek(dayOfWeek);

  Future<void> loadPlannedExercisesForDay(int dayOfWeek) =>
      selectDayOfWeek(dayOfWeek);

  Future<void> addPlannedExercise(PlannedExercise exercise) async {
    await _dbManager.insertPlannedExercise(exercise);
    if (exercise.dayOfWeek == selectedDayOfWeek) {
      plannedExercisesForSelectedDay =
          await _dbManager.getPlannedExercisesForDay(selectedDayOfWeek);
    }
    notifyListeners();
  }

  Future<void> removePlannedExercise(int id) async {
    await _dbManager.deletePlannedExercise(id);
    plannedExercisesForSelectedDay =
        await _dbManager.getPlannedExercisesForDay(selectedDayOfWeek);
    notifyListeners();
  }

  Future<void> deletePlannedExercise(int id) => removePlannedExercise(id);

  Future<void> startNewWorkout(String name) async {
    final today = DateTime.now().toIso8601String().split('T').first;
    final workout = Workout(
      name: name,
      date: today,
      completed: false,
    );

    final id = await _dbManager.insertWorkout(workout);
    activeWorkout = workout.copyWith(id: id);
    currentSets = [];
    workouts = await _dbManager.getWorkouts();
    notifyListeners();
  }

  Future<void> addSetToCurrentWorkout(
    String exerciseName,
    double weight,
    int reps,
  ) async {
    if (activeWorkout == null || activeWorkout!.id == null) return;

    final nextSetNumber = currentSets.length + 1;
    final workoutSet = WorkoutSet(
      workoutId: activeWorkout!.id!,
      exerciseName: exerciseName,
      setNumber: nextSetNumber,
      weight: weight,
      reps: reps,
    );

    final id = await _dbManager.insertSet(workoutSet);
    currentSets.add(workoutSet.copyWith(id: id));
    personalRecords = await _dbManager.getPersonalRecords();
    notifyListeners();
  }

  Future<void> finishActiveWorkout() async {
    if (activeWorkout == null || activeWorkout!.id == null) return;

    await _dbManager.completeWorkout(activeWorkout!.id!);
    workouts = await _dbManager.getWorkouts();
    activeWorkout = null;
    currentSets = [];
    notifyListeners();
  }
}
