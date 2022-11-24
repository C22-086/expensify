import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterEmpty()) {
    on<FetchRegister>((event, emit) async {
      emit(const RegisterLoading(true));
    });

    on<FetchRegisterDone>((event, emit) async {
      emit(const RegisterLoading(false));
    });
  }
}
