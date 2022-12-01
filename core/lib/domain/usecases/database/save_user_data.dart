import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SaveUserData {
  final DatabaseRepository repository;

  SaveUserData(this.repository);

  Future<Either<Failure, void>> execute(String name, String email, String uid) {
    return repository.saveUserData(name: name, email: email, uid: uid);
  }
}
