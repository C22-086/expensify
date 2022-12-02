part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object?> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseLoading extends DatabaseState {
  @override
  List<Object?> get props => [];
}

class DatabaseSuccess extends DatabaseState {
  @override
  List<Object?> get props => [];
}

class DatabaseError extends DatabaseState {
  final String error;

  const DatabaseError(this.error);
  @override
  List<Object?> get props => [error];
}
