part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadingGoogle extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthNotLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class Registered extends AuthState {
  final UserCredential userCredential;

  Registered({required this.userCredential});

  @override
  List<Object?> get props => [userCredential];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
