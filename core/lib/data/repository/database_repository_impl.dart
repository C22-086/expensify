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
  Future<Either<Failure, void>> uploadImage(
      {required String uid, required File image}) async {
    try {
      late String imageUrl;
      String fileName = basename(image.path);
      final storage = FirebaseStorage.instance.ref();

      final imageRef = storage.child('images/$uid/$fileName');
      final ref = FirebaseDatabase.instance.ref('users/$uid');

      final upload = imageRef.putFile(image);
      upload.snapshotEvents.listen((event) async {
        if (event.state == TaskState.success) {
          imageUrl = await imageRef.getDownloadURL();
          await ref.update({
            'imageProfile': imageUrl,
          });
        }
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> pushIncomeUser(
      {required String name,
      required String uid,
      required String category,
      required int nominal,
      required String note}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('transaction/$uid');
      final push = ref.push();
      await push.set({
        'type': 'income',
        'transactionId': push.key!,
        'userId': uid,
        'name': name,
        'category': category,
        'nominal': nominal,
        'note': note,
        'incomeDate': DateTime.now().toString()
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> pushExpanseUser(
      {required String name,
      required String uid,
      required String category,
      required int nominal,
      required String note}) async {
    try {
      final ref = FirebaseDatabase.instance.ref('transaction/$uid');
      final push = ref.push();
      await push.set({
        'type': 'expanse',
        'transactionId': push.key!,
        'userId': uid,
        'name': name,
        'category': category,
        'nominal': nominal,
        'note': note,
        'expanseDate': DateTime.now().toString()
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
