// ignore_for_file: must_be_immutable

import 'package:core/data/models/income_model.dart';
import 'package:equatable/equatable.dart';

import 'expanse_model.dart';

class UserModel extends Equatable {
  UserModel(
    this.userId,
    this.name,
    this.email,
    this.password,
    this.expanses,
    this.incomes, {
    this.balance = 0,
  });

  int userId;
  String name;
  String email;
  String password;
  List<ExpanseModel> expanses;
  List<IncomeModel> incomes;
  int balance;

  @override
  List<Object?> get props => [userId, email, password, balance];
}
