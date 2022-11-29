import 'package:equatable/equatable.dart';

class ExpanseModel extends Equatable {
  final String expanseId;
  final String userId;
  final String name;
  final String category;
  final int nominal;
  final String note;
  final DateTime expanseDate;

  const ExpanseModel(
      {required this.expanseId,
      required this.userId,
      required this.name,
      required this.category,
      required this.nominal,
      required this.note,
      required this.expanseDate});

  @override
  List<Object?> get props => [
        expanseId,
        userId,
        name,
        category,
        nominal,
        note,
        expanseDate,
      ];
}
