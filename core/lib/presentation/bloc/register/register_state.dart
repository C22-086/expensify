// ignore_for_file: must_be_immutable

part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterEmpty extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoading extends RegisterState {
  final bool state;

  const RegisterLoading(this.state);
  @override
  List<Object?> get props => [state];
}

class RegisterError extends RegisterState {
  final String message;

  const RegisterError(this.message);

  @override
  List<Object?> get props => [message];
}

class RegisterEmail extends RegisterState {
  final String message;

  const RegisterEmail(this.message);

  @override
  List<Object?> get props => [message];
}
