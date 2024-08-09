import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/core/usecases/usecase.dart';
import 'package:to_do_app/core/utils/error_utils.dart';
import 'package:to_do_app/src/auth/data/models/local_user_model.dart';

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignInUseCase implements UseCaseWithParams<LocalUserModel, SignInParams> {
  const SignInUseCase(this._authClient);

  final FirebaseAuth _authClient;

  @override
  ResultFuture<LocalUserModel> call(SignInParams params) async {
    try {
      final userCredential = await _authClient.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw const ServerException(message: 'Something went really wrong', statusCode: '505');
      }

      return Right(LocalUserModel.fromFirebaseUser(userCredential.user!));
    } on FirebaseAuthException catch (e, stackTrace) {
      ErrorUtils.printException(e, stackTrace);
      throw ServerException(message: e.message ?? 'Something went wrong', statusCode: e.code);
    } on ServerException catch (e, stackTrace) {
      rethrow;
    } catch (e, stackTrace) {
      ErrorUtils.printException(e, stackTrace);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
