import 'package:core/data/models/income_model.dart';
import 'package:equatable/equatable.dart';

import 'expanse_model.dart';

class UserModel extends Equatable {
  UserModel(
    this.userId,
    this.email,
    this.password,
    this.expanses, {
    this.balance = 0,
  });

  int userId;
  String email;
  String password;
  List<ExpanseModel>? expanses;
  List<IncomeModel>? incomes;
  int balance;

  @override
  List<Object?> get props => [userId, email, password, balance];
}
