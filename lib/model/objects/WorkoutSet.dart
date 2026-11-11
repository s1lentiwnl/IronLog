import 'dart:convert';

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
      'id': id,
      'workout_id': workoutId,
      'exercise_name': exerciseName,
      'set_number': setNumber,
      'weight': weight,
      'reps': reps,
    };
  }

  factory WorkoutSet.fromMap(Map<String, dynamic> map) {
    return WorkoutSet(
      id: map['id'] as int?,
      workoutId: map['workout_id'] as int,
      exerciseName: map['exercise_name'] as String,
      setNumber: map['set_number'] as int,
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'] as int,
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
