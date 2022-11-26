import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> init() async {
  locator.registerFactory(() => LoginBloc());
  locator.registerFactory(() => RegisterBloc());
  locator.registerFactory(() => OnboardingCubit());
}
