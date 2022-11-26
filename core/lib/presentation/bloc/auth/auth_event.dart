part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  LogInRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;

  RegisterRequested(this.email, this.password);
}

class GoogleLogInRequested extends AuthEvent {}

class LogOutRequested extends AuthEvent {}
