import 'package:equatable/equatable.dart';

class Income extends Equatable {
  final String incomeId;
  final String userId;
  final String name;
  final String category;
  final int amount;
  final String title;
  final String expanseDate;

  const Income(
      {required this.incomeId,
      required this.userId,
      required this.name,
      required this.category,
      required this.amount,
      required this.title,
      required this.expanseDate});

  @override
  List<Object?> get props =>
      [incomeId, userId, name, category, amount, title, expanseDate];
}
