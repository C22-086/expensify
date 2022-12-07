import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class PushExpanseUser {
  final DatabaseRepository repository;

  PushExpanseUser(this.repository);

  Future<Either<Failure, void>> execute(
      String name, String uid, String category, int nominal, String note) {
    return repository.pushExpanseUser(
        name: name, uid: uid, category: category, nominal: nominal, note: note);
  }
}
