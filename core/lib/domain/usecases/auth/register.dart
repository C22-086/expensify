import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register {
  final AuthRepositoryImpl repository;

  Register(this.repository);

  Future<Either<Failure, UserCredential>> execute(
      String name, String email, String password) {
    return repository.register(email: email, password: password, name: name);
  }
}
