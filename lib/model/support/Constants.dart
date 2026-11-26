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

  // Navigation tab labels (Italiano)
  static const String labelNavHome = 'Home';
  static const String labelNavPlanner = 'Schede';
  static const String labelNavWorkout = 'Allenamento';
  static const String labelNavSettings = 'Impostazioni';

  // Days of the week (1 = Lunedì ... 7 = Domenica)
  static const List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];

  static const List<String> weekDayInitials = [
    'L',
    'M',
    'M',
    'G',
    'V',
    'S',
    'D',
  ];

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

  static const Map<int, String> monthShortLabels = {
    1: 'Gen',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'Mag',
    6: 'Giu',
    7: 'Lug',
    8: 'Ago',
    9: 'Set',
    10: 'Ott',
    11: 'Nov',
    12: 'Dic',
  };

  // Home screen UI strings (Italiano)
  static const String labelToday = 'Oggi';
  static const String labelTodayWorkout = 'ALLENAMENTO DI OGGI';
  static const String labelDefaultSplit = 'ALLENAMENTO';
  static const String labelStartsWith = 'Si parte con:';
  static const String labelStartWorkout = 'Inizia allenamento';
  static const String labelCompleted = 'completato';
  static const String labelRestDayOverline = 'GIORNO DI RIPOSO';
  static const String labelRestDayMessage =
      'Goditi il riposo, te lo sei meritato.';
  static const String labelPlanWorkout = 'Pianifica scheda';
  static const String labelPrSectionTitle = 'I tuoi PR a colpo d\'occhio';
  static const String labelBestLift = 'Miglior alzata';
  static const String labelNoRecord = 'Nessun record';
  static const String labelNoRecordSubtitle = 'Registra una serie';
  static const String unitKg = 'kg';

  // AI Assistant UI strings (Italiano)
  static const String labelAiBannerTitle = 'Non fermare l\'allenamento.';
  static const String labelAiBannerSubtitle =
      'Assistente AI esercizi sostitutivi';
  static const String labelAiDialogTitle = 'Assistente AI Sostituzioni';
  static const String labelAiDialogSubtitle =
      'Indica il macchinario o l\'esercizio occupato per ricevere subito un\'alternativa valida.';
  static const String labelAiInputHint = 'Quale macchinario è occupato?';
  static const String labelAiAskButton = 'Chiedi alternativa';
  static const String labelAiEmptyInputError =
      'Inserisci il nome di un macchinario o di un esercizio.';
  static const String labelAiResponseTitle = 'Alternativa suggerita';
  static const String labelAiResponseNotice =
      'Risposta simulata in attesa dell\'integrazione AI finale.';
  static const String labelClose = 'Chiudi';
  static const String tooltipAiAssistant = 'Apri Assistente AI Sostituzioni';
}
