import 'dart:io';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final SaveUserData saveUserData;
  final EditUserData editUserData;
  final UploadImageUser uploadImageUser;
  final PushIncomeUser pushIncomeUser;
  final PushExpanseUser pushExpanseUser;

  DatabaseBloc(
      {required this.saveUserData,
      required this.editUserData,
      required this.uploadImageUser,
      required this.pushIncomeUser,
      required this.pushExpanseUser})
      : super(DatabaseInitial()) {
    on<DatabaseSaveUser>(_saveUserData);
    on<DatabaseEditUser>(_editUserData);
    on<DatabaseUploadImage>(_uploadUserImage);
    on<DatabasePushIncomeUser>(_pushIncomeUser);
    on<DatabasePushExpanseUser>(_pushExpanseUser);
  }

  _saveUserData(DatabaseSaveUser event, Emitter<DatabaseState> emit) async {
    emit(DatabaseLoading());
    final listofUserData =
        await saveUserData.execute(event.email, event.name, event.uid);
    listofUserData.fold((l) => null, (r) => null);
  }

  _editUserData(DatabaseEditUser event, Emitter<DatabaseState> emit) async {
    emit(DatabaseLoading());
    final editData = await editUserData.execute(event.name, event.uid);
    editData.fold(
        (l) => emit(DatabaseError(l.message)), (r) => emit(DatabaseSuccess()));
  }

  _uploadUserImage(
      DatabaseUploadImage event, Emitter<DatabaseState> emit) async {
    emit(DatabaseLoading());
    final editData = await uploadImageUser.execute(event.uid, event.image);
    editData.fold(
        (l) => emit(DatabaseError(l.message)), (r) => emit(DatabaseSuccess()));
  }

  _pushIncomeUser(
      DatabasePushIncomeUser event, Emitter<DatabaseState> emit) async {
    emit(DatabaseLoading());
    final editData = await pushIncomeUser.execute(
        event.name, event.uid, event.category, event.nominal, event.note);
    editData.fold(
        (l) => emit(DatabaseError(l.message)), (r) => emit(DatabaseSuccess()));
  }

  _pushExpanseUser(
      DatabasePushExpanseUser event, Emitter<DatabaseState> emit) async {
    emit(DatabaseLoading());
    final editData = await pushExpanseUser.execute(
        event.name, event.uid, event.category, event.nominal, event.note);
    editData.fold(
        (l) => emit(DatabaseError(l.message)), (r) => emit(DatabaseSuccess()));
  }
}
