import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class PushIncomeUser {
  final DatabaseRepository repository;

  PushIncomeUser(this.repository);

  Future<Either<Failure, void>> execute(
      String name, String uid, String category, int nominal, String note) {
    return repository.pushIncomeUser(
        name: name, uid: uid, category: category, nominal: nominal, note: note);
  }
}
