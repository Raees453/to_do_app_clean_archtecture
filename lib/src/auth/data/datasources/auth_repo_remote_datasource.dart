import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/core/errors/exceptions.dart';
import 'package:to_do_app/core/utils/error_utils.dart';
import 'package:to_do_app/src/auth/data/models/local_user_model.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_in_usecase.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_up_usecase.dart';

abstract class AuthRepoRemoteDataSrc {
  const AuthRepoRemoteDataSrc();

  Future<void> signUp(SignUpParams params);

  Future<LocalUserModel> signIn(SignInParams params);
}

class AuthRepoRemoteDataSrcImpl extends AuthRepoRemoteDataSrc {
  const AuthRepoRemoteDataSrcImpl(this.cloudStorageClient, this.authClient);

  final FirebaseAuth authClient;
  final FirebaseFirestore cloudStorageClient;

  @override
  Future<LocalUserModel> signIn(SignInParams params) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(SignUpParams params) async {
    try {
      final credentials = await authClient.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );

      await credentials.user?.updateDisplayName(params.name);

      await _writeUserToDB(authClient.currentUser!);
    } on FirebaseAuthException catch (e, stackTrace) {
      ErrorUtils.printException(e, stackTrace);
      throw ServerException(message: e.message ?? 'Some Error Occurred', statusCode: e.code);
    } catch (e, stackTrace) {
      ErrorUtils.printException(e, stackTrace);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<void> _writeUserToDB(User user) async {
    await cloudStorageClient.collection('users').doc(user.uid).set(
          LocalUserModel.fromFirebaseUser(user).toJson(),
        );
  }
}
