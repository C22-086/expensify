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

class DatabaseUploadImage extends DatabaseEvent {
  final String uid;
  final File image;
  const DatabaseUploadImage({required this.uid, required this.image});

  @override
  List<Object?> get props => [image, uid];
}

class DatabasePushIncomeUser extends DatabaseEvent {
  final String name;
  final String uid;
  final String category;
  final int nominal;
  final String note;

  const DatabasePushIncomeUser({
    required this.name,
    required this.uid,
    required this.category,
    required this.nominal,
    required this.note,
  });

  @override
  List<Object?> get props => [name, uid];
}

class DatabasePushExpanseUser extends DatabaseEvent {
  final String name;
  final String uid;
  final String category;
  final int nominal;
  final String note;

  const DatabasePushExpanseUser({
    required this.name,
    required this.uid,
    required this.category,
    required this.nominal,
    required this.note,
  });

  @override
  List<Object?> get props => [name, uid];
}
