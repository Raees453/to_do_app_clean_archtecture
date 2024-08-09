import 'package:equatable/equatable.dart';
import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/core/usecases/usecase.dart';
import 'package:to_do_app/src/home/data/models/task_model.dart';
import 'package:to_do_app/src/home/domain/repos/tasks_repo.dart';

class CreateTaskParams extends Equatable {
  final String name;
  final DateTime date;

  const CreateTaskParams({required this.name, required this.date});

  @override
  List<Object?> get props => [name, date];
}

class CreateTaskUseCase extends UseCaseWithParams<TaskModel, CreateTaskParams> {
  const CreateTaskUseCase(this._tasksRepo);

  final TasksRepo _tasksRepo;

  @override
  ResultFuture<TaskModel> call(CreateTaskParams params) => _tasksRepo.createTask(params);
}
