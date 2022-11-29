part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  LogInRequested({
    required this.email,
    required this.password,
  });
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final int? balance;

  RegisterRequested(this.balance,
      {required this.email, required this.password, required this.name});
}

class GoogleLogInRequested extends AuthEvent {}

class LogOutRequested extends AuthEvent {}
