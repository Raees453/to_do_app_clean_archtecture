import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/core/injection/dependency_injection.dart';
import 'package:to_do_app/src/home/data/models/task_model.dart';
import 'package:to_do_app/src/home/data/repos/tasks_repo.dart';
import 'package:to_do_app/src/home/domain/usecases/create_task_usecase.dart';
import 'package:to_do_app/src/home/domain/usecases/get_tasks_usecase.dart';

class TasksNotifier extends AsyncNotifier<List<TaskModel>> {
  TasksNotifier(this._createTaskUseCase, this._getTasksUseCase) : super();

  final CreateTaskUseCase _createTaskUseCase;
  final GetTasksUseCase _getTasksUseCase;

  Future<bool> createTask(CreateTaskParams params) async {
    final tasks = state.value ?? [];

    state = const AsyncValue.loading();

    final result = await _createTaskUseCase(params);

    bool status = false;

    result.fold((failure) {
      // TODO Each Failure should have stacktrace property in order to update the state
      state = AsyncValue.error(failure, StackTrace.current);
    }, (task) {
      tasks.add(task);
      state = AsyncValue.data(tasks);
      status = true;
    });

    return status;
  }

  @override
  FutureOr<List<TaskModel>> build() async {
    final result = await _getTasksUseCase.call();

    return result.fold((failure) => throw failure, (tasks) => tasks);
  }
}

final tasksProvider = AsyncNotifierProvider<TasksNotifier, List<TaskModel>>(
  () => TasksNotifier(
    CreateTaskUseCase(instance<TasksRepoImpl>()),
    GetTasksUseCase(instance<TasksRepoImpl>()),
  ),
);
