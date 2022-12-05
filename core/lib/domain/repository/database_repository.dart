import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, void>> saveUserData(
      {required String name, required String email, required String uid});
  Future<Either<Failure, void>> getUserData(
      {required String name, required String email, required String uid});
  Future<Either<Failure, void>> editUserData(
      {required String name, required String uid});
  Future<Either<Failure, String>> uploadImage(
      {required String uid, required File image});
}
