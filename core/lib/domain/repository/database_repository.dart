import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class DatabaseRepository {
  Future<Either<Failure, void>> saveUserData(
      {required String name, required String email, required String uid});
  Future<Either<Failure, void>> editUserData(
      {required String name, required String uid});
  Future<Either<Failure, void>> uploadImage(
      {required String uid, required File image});
  Future<Either<Failure, void>> pushIncomeUser({
    required String name,
    required String uid,
    required String category,
    required int amount,
    required String title,
    required String date,
  });
  Future<Either<Failure, void>> pushExpanseUser({
    required String name,
    required String uid,
    required String category,
    required int amount,
    required String title,
    required String date,
  });
}
