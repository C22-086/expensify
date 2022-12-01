import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> register(
      {required String name, required String email, required String password});
  Future<Either<Failure, void>> logIn(
      {required String email, required String password});
  Future<Either<Failure, void>> logInWithGoogle();
  Future<void> logOut();
}
