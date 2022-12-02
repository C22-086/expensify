import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  @override
  Future<Either<Failure, void>> saveUserData(
      {required String name,
      required String email,
      required String uid}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      await ref.set({
        'uid': uid,
        'name': name,
        'email': email,
        'balance': 0,
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> getUserData(
      {required String name,
      required String email,
      required String uid}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      await ref.set({
        'name': name,
        'email': email,
        'balance': 0,
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editUserData(
      {required String name, required String uid}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      await ref.update({
        'name': name,
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
