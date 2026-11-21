import 'dart:convert';

import '../support/Constants.dart';

class Workout {
  final int? id;
  final String name;
  final String date;
  final bool completed;

  const Workout({
    this.id,
    required this.name,
    required this.date,
    this.completed = false,
  });

  Workout copyWith({
    int? id,
    String? name,
    String? date,
    bool? completed,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Constants.colId: id,
      Constants.colWorkoutName: name,
      Constants.colWorkoutDate: date,
      Constants.colWorkoutCompleted: completed ? 1 : 0,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map[Constants.colId] as int?,
      name: map[Constants.colWorkoutName] as String,
      date: map[Constants.colWorkoutDate] as String,
      completed: map[Constants.colWorkoutCompleted] == 1 ||
          map[Constants.colWorkoutCompleted] == true,
    );
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Workout(id: $id, name: $name, date: $date, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Workout &&
        other.id == id &&
        other.name == name &&
        other.date == date &&
        other.completed == completed;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ date.hashCode ^ completed.hashCode;
  }
}
