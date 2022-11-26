import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingCubit extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingCubit() : super(OnboardingState(0));

  void nextPage() {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(OnboardingState(state.pageIndex + 1));
  }
}
