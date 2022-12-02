part of 'database_bloc.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object?> get props => [];
}

class DatabaseSaveUser extends DatabaseEvent {
  final String name;
  final String email;
  final String uid;
  const DatabaseSaveUser(
      {required this.email, required this.name, required this.uid});
  @override
  List<Object?> get props => [name, email, uid];
}

class DatabaseEditUser extends DatabaseEvent {
  final String name;
  final String uid;
  const DatabaseEditUser({required this.name, required this.uid});

  @override
  List<Object?> get props => [name, uid];
}
