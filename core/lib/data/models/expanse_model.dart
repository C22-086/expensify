import 'package:equatable/equatable.dart';

class ExpanseModel extends Equatable {
  final String expanseId;
  final String userId;
  final String name;
  final String category;
  final int amount;
  final String title;
  final DateTime expanseDate;

  const ExpanseModel(
      {required this.expanseId,
      required this.userId,
      required this.name,
      required this.category,
      required this.amount,
      required this.title,
      required this.expanseDate});

  Map<String, dynamic> toJson() => {
        "expanseId": expanseId,
        "userId": userId,
        "name": name,
        "category": category,
        "amount": amount,
        "title": title,
        "expanseDate": expanseDate,
      };

  @override
  List<Object?> get props => [
        expanseId,
        userId,
        name,
        category,
        amount,
        title,
        expanseDate,
      ];
}
