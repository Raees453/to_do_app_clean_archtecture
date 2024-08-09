import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/src/home/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({required super.id, required super.name, required super.date});

  factory TaskModel.fromJson(Json map) => TaskModel(
        id: map['id'] as String,
        name: map['name'] as String,
        date: DateTime.parse(map['date'] as String),
      );

  Json toJson() => {'id': id, 'name': name, 'date': date.toString()};
}
