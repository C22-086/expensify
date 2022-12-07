import 'package:equatable/equatable.dart';

class IncomeModel extends Equatable {
  final String incomeId;
  final String userId;
  final String name;
  final String category;
  final int nominal;
  final String note;
  final String expanseDate;

  const IncomeModel({
    required this.incomeId,
    required this.userId,
    required this.name,
    required this.category,
    required this.nominal,
    required this.note,
    required this.expanseDate,
  });

  Map<String, dynamic> toJson() => {
        "incomeId": incomeId,
        "userId": userId,
        "name": name,
        "category": category,
        "nominal": nominal,
        "note": note,
        "expanseDate": expanseDate,
      };

  @override
  List<Object?> get props => [
        incomeId,
        userId,
        name,
        category,
        nominal,
        note,
        expanseDate,
      ];
}
