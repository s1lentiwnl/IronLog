import 'dart:convert';

import '../support/Constants.dart';

class WorkoutSet {
  final int? id;
  final int workoutId;
  final String exerciseName;
  final int setNumber;
  final double weight;
  final int reps;

  const WorkoutSet({
    this.id,
    required this.workoutId,
    required this.exerciseName,
    required this.setNumber,
    required this.weight,
    required this.reps,
  });

  WorkoutSet copyWith({
    int? id,
    int? workoutId,
    String? exerciseName,
    int? setNumber,
    double? weight,
    int? reps,
  }) {
    return WorkoutSet(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseName: exerciseName ?? this.exerciseName,
      setNumber: setNumber ?? this.setNumber,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Constants.colId: id,
      Constants.colSetWorkoutId: workoutId,
      Constants.colSetExerciseName: exerciseName,
      Constants.colSetNumber: setNumber,
      Constants.colSetWeight: weight,
      Constants.colSetReps: reps,
    };
  }

  factory WorkoutSet.fromMap(Map<String, dynamic> map) {
    return WorkoutSet(
      id: map[Constants.colId] as int?,
      workoutId: map[Constants.colSetWorkoutId] as int,
      exerciseName: map[Constants.colSetExerciseName] as String,
      setNumber: map[Constants.colSetNumber] as int,
      weight: (map[Constants.colSetWeight] as num).toDouble(),
      reps: map[Constants.colSetReps] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutSet.fromJson(String source) =>
      WorkoutSet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkoutSet(id: $id, workoutId: $workoutId, exerciseName: $exerciseName, setNumber: $setNumber, weight: $weight, reps: $reps)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkoutSet &&
        other.id == id &&
        other.workoutId == workoutId &&
        other.exerciseName == exerciseName &&
        other.setNumber == setNumber &&
        other.weight == weight &&
        other.reps == reps;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        workoutId.hashCode ^
        exerciseName.hashCode ^
        setNumber.hashCode ^
        weight.hashCode ^
        reps.hashCode;
  }
}
