import 'package:core/core.dart';
import 'package:core/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, void>> saveUserData(
      {required String name, required String email, required String uid});
  Future<Either<Failure, UserData>> fetchUserData({required String uid});
}
