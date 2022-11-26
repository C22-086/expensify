import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> init() async {
  // BLOC
  locator.registerFactory(() => AuthBloc(
      logIn: locator(),
      logOut: locator(),
      logInGoogle: locator(),
      register: locator()));

  // REPOSITORY
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(firebaseAuth: locator()),
  );

  // USECASE
  locator.registerLazySingleton(() => Register(locator()));
  locator.registerLazySingleton(() => LogOut(locator()));
  locator.registerLazySingleton(() => LogInGoogle(locator()));
  locator.registerLazySingleton(() => LogIn(locator()));

  // FIREBASE
  locator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
}
