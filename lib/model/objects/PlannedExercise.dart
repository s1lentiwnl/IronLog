import 'dart:convert';

import '../support/Constants.dart';

class PlannedExercise {
  final int? id;
  final int dayOfWeek;
  final String splitName;
  final String exerciseName;
  final int targetSets;
  final int targetReps;
  final int restSeconds;

  const PlannedExercise({
    this.id,
    required this.dayOfWeek,
    required this.splitName,
    required this.exerciseName,
    required this.targetSets,
    required this.targetReps,
    required this.restSeconds,
  });

  PlannedExercise copyWith({
    int? id,
    int? dayOfWeek,
    String? splitName,
    String? exerciseName,
    int? targetSets,
    int? targetReps,
    int? restSeconds,
  }) {
    return PlannedExercise(
      id: id ?? this.id,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      splitName: splitName ?? this.splitName,
      exerciseName: exerciseName ?? this.exerciseName,
      targetSets: targetSets ?? this.targetSets,
      targetReps: targetReps ?? this.targetReps,
      restSeconds: restSeconds ?? this.restSeconds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Constants.colId: id,
      Constants.colPlannedDayOfWeek: dayOfWeek,
      Constants.colPlannedSplitName: splitName,
      Constants.colPlannedExerciseName: exerciseName,
      Constants.colPlannedTargetSets: targetSets,
      Constants.colPlannedTargetReps: targetReps,
      Constants.colPlannedRestSeconds: restSeconds,
    };
  }

  factory PlannedExercise.fromMap(Map<String, dynamic> map) {
    return PlannedExercise(
      id: map[Constants.colId] as int?,
      dayOfWeek: (map[Constants.colPlannedDayOfWeek] as num).toInt(),
      splitName: map[Constants.colPlannedSplitName] as String? ?? '',
      exerciseName: map[Constants.colPlannedExerciseName] as String? ?? '',
      targetSets: (map[Constants.colPlannedTargetSets] as num).toInt(),
      targetReps: (map[Constants.colPlannedTargetReps] as num).toInt(),
      restSeconds: (map[Constants.colPlannedRestSeconds] as num).toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlannedExercise.fromJson(String source) =>
      PlannedExercise.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlannedExercise(id: $id, dayOfWeek: $dayOfWeek, splitName: $splitName, exerciseName: $exerciseName, targetSets: $targetSets, targetReps: $targetReps, restSeconds: $restSeconds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlannedExercise &&
        other.id == id &&
        other.dayOfWeek == dayOfWeek &&
        other.splitName == splitName &&
        other.exerciseName == exerciseName &&
        other.targetSets == targetSets &&
        other.targetReps == targetReps &&
        other.restSeconds == restSeconds;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dayOfWeek.hashCode ^
        splitName.hashCode ^
        exerciseName.hashCode ^
        targetSets.hashCode ^
        targetReps.hashCode ^
        restSeconds.hashCode;
  }
}
