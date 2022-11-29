import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, List<UserModel>>> retrieveUserData();
}
