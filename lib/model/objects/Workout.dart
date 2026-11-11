import 'dart:convert';

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
      'id': id,
      'name': name,
      'date': date,
      'completed': completed ? 1 : 0,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] as int?,
      name: map['name'] as String,
      date: map['date'] as String,
      completed: map['completed'] == 1 || map['completed'] == true,
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
