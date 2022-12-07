import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class UploadImageUser {
  final DatabaseRepository repository;

  UploadImageUser(this.repository);

  Future<Either<Failure, void>> execute(String uid, File image) {
    return repository.uploadImage(uid: uid, image: image);
  }
}
