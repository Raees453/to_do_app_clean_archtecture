import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/core/errors/failure.dart';
import 'package:to_do_app/src/home/data/datasources/tasks_datasource.dart';
import 'package:to_do_app/src/home/data/models/task_model.dart';
import 'package:to_do_app/src/home/domain/repos/tasks_repo.dart';
import 'package:to_do_app/src/home/domain/usecases/create_task_usecase.dart';
import 'package:to_do_app/src/home/domain/usecases/delete_task_usecase.dart';
import 'package:to_do_app/src/home/domain/usecases/update_task_usecase.dart';

class TasksRepoImpl extends TasksRepo {
  const TasksRepoImpl(this._dataSrc);

  final TasksRepoRemoteDataSrc _dataSrc;

  @override
  ResultFuture<TaskModel> createTask(CreateTaskParams params) async {
    try {
      final result = await _dataSrc.createTask(params);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<TaskModel>> getTasks() async {
    try {
      final result = await _dataSrc.getTasks();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteTask(DeleteTaskParams params) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  ResultFuture<TaskModel> updateTask(UpdateTaskParams params) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
