import 'package:equatable/equatable.dart';
import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/core/usecases/usecase.dart';
import 'package:to_do_app/src/auth/domain/repos/auth_repo.dart';

class SignUpParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const SignUpParams({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}

class SignUpUseCase extends UseCaseWithParams<void, SignUpParams> {
  const SignUpUseCase(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(SignUpParams params) async {
    return _authRepo.signUp(params);
  }
}
