import 'package:bloc/bloc.dart';
import 'package:to_do_app/src/auth/domain/usecases/sign_up_usecase.dart';
import 'package:to_do_app/src/auth/presentation/bloc/auth_events.dart';
import 'package:to_do_app/src/auth/presentation/bloc/auth_state.dart';

abstract class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.signUp) : super(const AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(const AuthLoading()));
    on<SignUpEvent>(_signUpHandler);
  }

  final SignUpUseCase signUp;

  Future<void> _signUpHandler(SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await signUp(
      SignUpParams(name: event.name, email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(const SignedUp()),
    );
  }
}
