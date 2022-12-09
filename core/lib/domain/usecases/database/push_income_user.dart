import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class PushIncomeUser {
  final DatabaseRepository repository;

  PushIncomeUser(this.repository);

  Future<Either<Failure, void>> execute(String name, String uid,
      String category, int amount, String title, String date) {
    return repository.pushIncomeUser(
      name: name,
      uid: uid,
      category: category,
      amount: amount,
      title: title,
      date: date,
    );
  }
}
