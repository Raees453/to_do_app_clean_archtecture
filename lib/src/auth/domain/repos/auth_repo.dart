import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/src/auth/data/models/local_user_model.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_in_usecase.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_up_usecase.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> signUp(SignUpParams params);

  ResultFuture<LocalUserModel> signIn(SignInParams params);

  ResultFuture<void> updateUser();
}
