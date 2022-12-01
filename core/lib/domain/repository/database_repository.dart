import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, void>> saveUserData(
      {required String name, required String email, required String uid});
}
