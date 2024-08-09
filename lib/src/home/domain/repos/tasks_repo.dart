import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/src/home/data/models/task_model.dart';
import 'package:to_do_app/src/home/domain/usecases/create_task_usecase.dart';
import 'package:to_do_app/src/home/domain/usecases/delete_task_usecase.dart';
import 'package:to_do_app/src/home/domain/usecases/update_task_usecase.dart';

abstract class TasksRepo {
  const TasksRepo();

  ResultFuture<TaskModel> createTask(CreateTaskParams params);

  ResultFuture<TaskModel> updateTask(UpdateTaskParams params);

  ResultFuture<List<TaskModel>> getTasks();

  ResultFuture<void> deleteTask(DeleteTaskParams params);
}
