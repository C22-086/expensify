import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  @override
  Future<Either<Failure, void>> saveUserData(
      {required String name,
      required String email,
      required String uid}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      await ref.set({
        'uid': uid,
        'name': name,
        'email': email,
        'balance': 0,
        'imageProfile': '',
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> getUserData(
      {required String name,
      required String email,
      required String uid}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      await ref.set({
        'name': name,
        'email': email,
        'balance': 0,
        'imageProfile': '',
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editUserData(
      {required String name, required String uid}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('users/$uid');
      await ref.update({
        'name': name,
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(
      {required String name, required String uid, required File image}) async {
    try {
      late String imageUrl;
      String fileName = basename(image.path);
      final storage = FirebaseStorage.instance.ref();

      final imageRef = storage.child('images/$uid/$fileName');

      final upload = imageRef.putFile(image);
      upload.snapshotEvents.listen((event) async {
        if (event.state == TaskState.success) {
          imageUrl = await imageRef.getDownloadURL();
        }
      });
      return Right(imageUrl);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
