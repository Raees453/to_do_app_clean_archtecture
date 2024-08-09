import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/core/errors/failure.dart';
import 'package:to_do_app/src/auth/data/datasources/auth_repo_remote_datasource.dart';
import 'package:to_do_app/src/auth/data/models/local_user_model.dart';
import 'package:to_do_app/src/auth/domain/repos/auth_repo.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_in_usecase.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_up_usecase.dart';

import '../../../../core/errors/exceptions.dart';

class AuthRepoImpl extends AuthRepo {
  const AuthRepoImpl(this._dataSrc);

  final AuthRepoRemoteDataSrc _dataSrc;

  @override
  ResultFuture<LocalUserModel> signIn(SignInParams params) async {
    try {
      final user = await _dataSrc.signIn(params);

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signUp(SignUpParams params) async {
    try {
      await _dataSrc.signUp(params);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
