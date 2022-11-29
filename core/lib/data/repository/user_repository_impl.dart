// import 'package:core/domain/entities/user.dart';
// import 'package:core/domain/repository/user_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:core/utils/failure.dart';
// import 'package:firebase_database/firebase_database.dart';

// class UserRepositoryImpl implements UserRepository {
//   final FirebaseDatabase database;

//   UserRepositoryImpl(this.database);
//   @override
//   Future<Either<Failure, User>> getUser() async {
//     final ref = FirebaseDatabase.instance.ref('users/123');
//     final snapshot = ref.child('users/123/').get();
//     if (snapshot.) {}
//   }

//   @override
//   Future<Either<Failure, void>> updateUser(User user) async {}
// }
