import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, UserData>> getUser();
  Future<Either<Failure, void>> updateUser(UserData user);
}
