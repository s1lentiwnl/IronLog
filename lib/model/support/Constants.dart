class Constants {
  Constants._();

  // Application metadata
  static const String appName = 'IronLog';

  // Database configuration
  static const String dbName = 'ironlog.db';
  static const int dbVersion = 3;

  // Table names
  static const String tableWorkouts = 'workouts';
  static const String tableWorkoutSets = 'workout_sets';
  static const String tablePlannedExercises = 'planned_exercises';

  // Common column names
  static const String colId = 'id';
  static const String colExerciseName = 'exercise_name';

  // 'workouts' table columns
  static const String colWorkoutName = 'name';
  static const String colWorkoutDate = 'date';
  static const String colWorkoutCompleted = 'completed';

  // 'workout_sets' table columns
  static const String colSetWorkoutId = 'workout_id';
  static const String colSetExerciseName = 'exercise_name';
  static const String colSetNumber = 'set_number';
  static const String colSetWeight = 'weight';
  static const String colSetReps = 'reps';
  static const String colMaxWeightAlias = 'max_weight';

  // 'planned_exercises' table columns
  static const String colPlannedDayOfWeek = 'day_of_week';
  static const String colPlannedSplitName = 'split_name';
  static const String colPlannedExerciseName = 'exercise_name';
  static const String colPlannedTargetSets = 'target_sets';
  static const String colPlannedTargetReps = 'target_reps';
  static const String colPlannedRestSeconds = 'rest_seconds';

  // Navigation tab indices
  static const int tabHome = 0;
  static const int tabPlanner = 1;
  static const int tabWorkout = 2;
  static const int tabSettings = 3;

  // Navigation tab labels
  static const String labelNavHome = 'Home';
  static const String labelNavPlanner = 'Planner';
  static const String labelNavWorkout = 'Workout';
  static const String labelNavSettings = 'Settings';

  // Days of the week (1 = Lunedì ... 7 = Domenica)
  static const List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];

  static const Map<int, String> weekDayShortLabels = {
    1: 'Lun',
    2: 'Mar',
    3: 'Mer',
    4: 'Gio',
    5: 'Ven',
    6: 'Sab',
    7: 'Dom',
  };

  static const Map<int, String> weekDayFullLabels = {
    1: 'Lunedì',
    2: 'Martedì',
    3: 'Mercoledì',
    4: 'Giovedì',
    5: 'Venerdì',
    6: 'Sabato',
    7: 'Domenica',
  };

  static const List<String> weekDayLabelsList = [
    'Lun',
    'Mar',
    'Mer',
    'Gio',
    'Ven',
    'Sab',
    'Dom',
  ];
}
