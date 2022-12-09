import 'package:equatable/equatable.dart';

class Income extends Equatable {
  final String transactionId;
  final String userId;
  final String name;
  final String category;
  final int amount;
  final String title;
  final String expanseDate;

  const Income({
    required this.transactionId,
    required this.userId,
    required this.name,
    required this.category,
    required this.amount,
    required this.title,
    required this.expanseDate,
  });

  Map<String, dynamic> toJson() => {
        "transaction": transactionId,
        "userId": userId,
        "name": name,
        "category": category,
        "amount": amount,
        "title": title,
        "expanseDate": expanseDate,
      };

  @override
  List<Object?> get props => [
        transactionId,
        userId,
        name,
        category,
        amount,
        title,
        expanseDate,
      ];
}
