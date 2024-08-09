import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/core/commons/typedefs.dart';
import 'package:to_do_app/core/injection/dependency_injection.dart';
import 'package:to_do_app/src/auth/data/models/local_user_model.dart';
import 'package:to_do_app/src/auth/data/repos/auth_repo_impl.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_in_usecase.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_up_usecase.dart';

enum AuthStatus { idle, loading, authenticated, error }

class AuthState extends Equatable {
  const AuthState({required this.status, this.error, this.user});

  final AuthStatus status;
  final String? error;
  final LocalUserModel? user;

  AuthState copyWith({
    AuthStatus? status,
    String? error,
    LocalUserModel? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, error, user];
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._signUp, this._signIn)
      : super(
          AuthState(
            status: AuthStatus.idle,
            user: instance<SharedPreferences>().getString('user') == null
                ? null
                : LocalUserModel.fromJson(
                    jsonDecode(instance<SharedPreferences>().getString('user')!) as Json,
                  ),
          ),
        );

  final SignUpUseCase _signUp;
  final SignInUseCase _signIn;

  Future<void> signUp(SignUpParams params) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _signUp(params);

    result.fold(
      (failure) => state = state.copyWith(error: failure.message, status: AuthStatus.error),
      (data) => state = state.copyWith(status: AuthStatus.authenticated),
    );
  }

  Future<void> signIn(SignInParams params) async {
    state = state.copyWith(status: AuthStatus.loading);

    final result = await _signIn(params);

    result.fold(
      (failure) => state = state.copyWith(status: AuthStatus.error, error: failure.message),
      (user) => state = state.copyWith(user: user, status: AuthStatus.authenticated),
    );
  }

  void updateState(LocalUserModel user) => state = state.copyWith(
        user: user,
        status: AuthStatus.authenticated,
      );
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    SignUpUseCase(instance<AuthRepoImpl>()),
    SignInUseCase(instance<FirebaseAuth>()),
  );
});
