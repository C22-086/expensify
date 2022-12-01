import 'package:core/core.dart';
import 'package:core/domain/entities/user.dart';
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
  Future<Either<Failure, UserData>> fetchUserData({required String uid}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');

      final name = ref.child('name');
      final email = ref.child('email');
      final balance = ref.child('balance');
      final uid2 = ref.child('uid');
      final user = UserData(
          email: email.key,
          userId: uid2.key,
          name: name.key,
          balance: int.parse(balance.key!));
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
