import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/core/usecases/usecase.dart';
import 'package:to_do_app/src/home/data/models/task_model.dart';
import 'package:to_do_app/src/home/domain/repos/tasks_repo.dart';

class GetTasksUseCase extends UseCaseWithoutParams<List<TaskModel>> {
  const GetTasksUseCase(this._tasksRepo);

  final TasksRepo _tasksRepo;

  @override
  ResultFuture<List<TaskModel>> call() => _tasksRepo.getTasks();
}
