import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class LogIn {
  final AuthRepository repository;

  LogIn(this.repository);

  Future<Either<Failure, void>> execute(String email, String password) {
    return repository.logIn(email: email, password: password);
  }
}
