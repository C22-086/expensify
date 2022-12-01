// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  UserData({
    required this.userId,
    required this.name,
    required this.email,
    this.balance = 0,
  });

  String? userId;
  String? email;
  String? name;
  int balance;

  factory UserData.fromMap(Map<dynamic, dynamic> map) {
    return UserData(
      name: map['name'],
      email: map['email'],
      userId: map['userId'],
      balance: map['balance'],
    );
  }

  @override
  List<Object?> get props => [userId, email, balance];
}
