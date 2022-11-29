// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class User extends Equatable {
  User(
    this.userId,
    this.email,
    this.password, {
    this.balance = 0,
  });

  String userId;
  String email;
  String password;
  int balance;

  @override
  List<Object?> get props => [userId, email, password, balance];
}
