import 'package:core/presentation/bloc/login/login_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> init() async {
  locator.registerFactory(() => LoginBloc());
}
