import 'package:equatable/equatable.dart';

class Expanse extends Equatable {
  final String expanseId;
  final String userId;
  final String name;
  final String category;
  final int amount;
  final String title;
  final DateTime expanseDate;

  const Expanse(
      {required this.expanseId,
      required this.userId,
      required this.name,
      required this.category,
      required this.amount,
      required this.title,
      required this.expanseDate});

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
