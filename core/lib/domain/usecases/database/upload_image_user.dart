import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class UploadImageUser {
  final DatabaseRepository repository;

  UploadImageUser(this.repository);

  Future<Either<Failure, String>> execute(String name, String uid, File image) {
    return repository.uploadImage(name: name, uid: uid, image: image);
  }
}
