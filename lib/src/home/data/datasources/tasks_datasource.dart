import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/core/utils/error_utils.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/src/auth/presentation/provider/auth_provider.dart';
import 'package:to_do_app/src/home/data/models/task_model.dart';
import 'package:to_do_app/src/home/domain/usecases/create_task_usecase.dart';
import 'package:to_do_app/src/home/domain/usecases/delete_task_usecase.dart';
import 'package:to_do_app/src/home/domain/usecases/update_task_usecase.dart';

abstract class TasksRepoRemoteDataSrc {
  const TasksRepoRemoteDataSrc();

  Future<TaskModel> createTask(CreateTaskParams params);

  Future<List<TaskModel>> getTasks();

  Future<TaskModel> updateTask(UpdateTaskParams params);

  Future<void> deleteTask(DeleteTaskParams params);
}

class TasksRepoRemoteDataSrcImpl implements TasksRepoRemoteDataSrc {
  const TasksRepoRemoteDataSrcImpl(this._dbClient);

  final FirebaseFirestore _dbClient;

  @override
  Future<TaskModel> createTask(CreateTaskParams params) async {
    try {
      final userId = parentScope.read(authStateProvider).user!.id;

      final ref = _dbClient.collection('users').doc(userId).collection('tasks').doc();

      await ref.set({'id': ref.id, 'name': params.name, 'date': params.date.toString()});

      final data = (await ref.get()).data()!..putIfAbsent('id', () => ref.id);

      print('DDDD is: ${data.toString()}');

      return TaskModel.fromJson(data);
    } catch (e, stackTrace) {
      ErrorUtils.printException(e, stackTrace);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> deleteTask(DeleteTaskParams params) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final userId = parentScope.read(authStateProvider).user!.id;

      final tasksJson = (await _dbClient.collection('users').doc(userId).collection('tasks').get())
          .docs
          .map((e) => e.data())
          .toList();

      return tasksJson.cast<Json>().map(TaskModel.fromJson).toList() ?? <TaskModel>[];
    } catch (e, stackTrace) {
      ErrorUtils.printException(e, stackTrace);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<TaskModel> updateTask(UpdateTaskParams params) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
