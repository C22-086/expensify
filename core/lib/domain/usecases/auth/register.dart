import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<Either<Failure, void>> execute(
      String name, String email, String password) {
    return repository.register(email: email, password: password, name: name);
  }
}
