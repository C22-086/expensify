import 'package:equatable/equatable.dart';

class Income extends Equatable {
  final String incomeId;
  final String userId;
  final String name;
  final String category;
  final int nominal;
  final String note;
  final String expanseDate;

  const Income(
      {required this.incomeId,
      required this.userId,
      required this.name,
      required this.category,
      required this.nominal,
      required this.note,
      required this.expanseDate});

  @override
  List<Object?> get props =>
      [incomeId, userId, name, category, nominal, note, expanseDate];
}
