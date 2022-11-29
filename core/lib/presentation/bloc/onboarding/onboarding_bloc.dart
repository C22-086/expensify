import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit(this.initialPage) : super(initialPage);
  int initialPage = 0;

  void nextPage() {
    emit(state + 1);
  }
}
