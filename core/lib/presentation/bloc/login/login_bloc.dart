import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

// Movie
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginEmpty()) {
    on<FetchLogin>((event, emit) async {
      emit(LoginLoading());
    });
  }
}
