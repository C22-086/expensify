import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final SaveUserData saveUserData;
  DatabaseBloc(this.saveUserData) : super(DatabaseInitial()) {
    on<DatabaseSaveUser>(_saveUserData);
  }

  _saveUserData(DatabaseSaveUser event, Emitter<DatabaseState> emit) async {
    emit(DatabaseLoading());
    final listofUserData =
        await saveUserData.execute(event.email, event.name, event.uid);
    listofUserData.fold((l) => null, (r) => null);
  }
}
