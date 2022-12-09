import 'package:equatable/equatable.dart';

class IncomeModel extends Equatable {
  final String incomeId;
  final String userId;
  final String name;
  final String category;
  final int amount;
  final String title;
  final String expanseDate;

  const IncomeModel({
    required this.incomeId,
    required this.userId,
    required this.name,
    required this.category,
    required this.amount,
    required this.title,
    required this.expanseDate,
  });

  Map<String, dynamic> toJson() => {
        "incomeId": incomeId,
        "userId": userId,
        "name": name,
        "category": category,
        "amount": amount,
        "title": title,
        "expanseDate": expanseDate,
      };

  @override
  List<Object?> get props => [
        incomeId,
        userId,
        name,
        category,
        amount,
        title,
        expanseDate,
      ];
}
