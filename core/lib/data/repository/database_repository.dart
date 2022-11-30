import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<Either<Failure, List<UserModel>>> retrieveUserData() {
    throw UnimplementedError();
  }
}
