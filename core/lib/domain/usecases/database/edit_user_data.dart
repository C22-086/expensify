import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class EditUserData {
  final DatabaseRepository repository;

  EditUserData(this.repository);

  Future<Either<Failure, void>> execute(String name, String uid) {
    return repository.editUserData(name: name, uid: uid);
  }
}
