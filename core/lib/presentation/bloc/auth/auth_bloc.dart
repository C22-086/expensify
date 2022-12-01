import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register register;
  final LogOut logOut;
  final LogInGoogle logInGoogle;
  final LogIn logIn;
  final SaveUserData saveUserData;

  AuthBloc(
      {required this.register,
      required this.logOut,
      required this.logInGoogle,
      required this.logIn,
      required this.saveUserData})
      : super(UnAuthenticated()) {
    on<LogInRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await logIn.execute(event.email, event.password);
      result.fold(
        (l) => {
          emit(AuthError(l.message)),
          emit(UnAuthenticated()),
        },
        (r) => emit(Authenticated()),
      );
    });
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await register.execute(
        event.name,
        event.email,
        event.password,
      );
      result.fold(
        (l) => {
          emit(AuthError(l.message)),
          emit(UnAuthenticated()),
        },
        (r) => emit(Registered(userCredential: r)),
      );
    });
    on<GoogleLogInRequested>((event, emit) async {
      emit(AuthLoadingGoogle());
      final result = await logInGoogle.execute();
      result.fold(
        (l) => {
          emit(AuthError(l.message)),
          emit(UnAuthenticated()),
        },
        (r) => emit(Authenticated()),
      );
    });
    on<LogOutRequested>((event, emit) async {
      emit(AuthLoading());
      await logOut.execute();
      emit(UnAuthenticated());
    });
  }
}
