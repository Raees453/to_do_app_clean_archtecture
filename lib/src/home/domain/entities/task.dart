class Task {
  final String id;
  final String name;
  final DateTime date;

  const Task({required this.id, required this.name, required this.date});

  Task copyWith({
    String? id,
    String? name,
    DateTime? date,
  }) =>
      Task(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
      );
}
