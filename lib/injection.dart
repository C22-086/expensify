import 'package:core/core.dart';
import 'package:core/data/repository/database_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> init() async {
  // BLOC
  locator.registerFactory(() => AuthBloc(
        logIn: locator(),
        logOut: locator(),
        logInGoogle: locator(),
        register: locator(),
        saveUserData: locator(),
      ));
  locator.registerFactory(() => DatabaseBloc(
        saveUserData: locator(),
        editUserData: locator(),
      ));
  locator.registerFactory(() => OnboardingCubit(0));
  locator.registerFactory(() => SetPage());
  locator.registerFactory(() => SetCategory());

  // REPOSITORY
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseAuth: locator(),
      databaseRepositoryImpl: locator(),
    ),
  );
  locator.registerFactory(() => AuthRepositoryImpl(
        firebaseAuth: locator(),
        databaseRepositoryImpl: locator(),
      ));
  locator.registerLazySingleton<DatabaseRepository>(
    () => DatabaseRepositoryImpl(),
  );
  locator.registerFactory(() => DatabaseRepositoryImpl());

  // USECASE
  locator.registerLazySingleton(() => Register(locator()));
  locator.registerLazySingleton(() => LogOut(locator()));
  locator.registerLazySingleton(() => LogInGoogle(locator()));
  locator.registerLazySingleton(() => LogIn(locator()));
  locator.registerLazySingleton(() => SaveUserData(locator()));
  locator.registerLazySingleton(() => EditUserData(locator()));

  // FIREBASE
  locator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  locator
      .registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);
}
