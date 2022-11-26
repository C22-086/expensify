import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class LogInGoogle {
  final AuthRepository repository;

  LogInGoogle(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.logInWithGoogle();
  }
}
