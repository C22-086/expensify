import 'package:core/core.dart';
import 'package:core/presentation/pages/onboarding_page.dart';
import 'package:expensify/firebase_options.dart';
import 'package:expensify/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? initializeApp;
bool? isLogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(
    name: 'Expensify',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initializing Dependecy Injection
  await di.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
    ),
  );
  final pref = await SharedPreferences.getInstance();
  initializeApp = pref.getBool('onboardingPassed');
  isLogin = pref.getBool('isLogin');

  FirebaseDatabase.instance.setPersistenceEnabled(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<SetPage>()),
        BlocProvider(create: (_) => di.locator<SetCategory>()),
        BlocProvider(create: (_) => di.locator<AuthBloc>()),
        BlocProvider(create: (_) => di.locator<OnboardingCubit>()),
        BlocProvider(create: (_) => di.locator<DatabaseBloc>()),
        BlocProvider(create: (_) => di.locator<ThemeBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Expensify',
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(),
            theme: ThemeData(colorScheme: kColorScheme),
            navigatorObservers: [routeObserver],
            initialRoute: initializeApp == false || initializeApp == null
                ? OnboardingPage.routeName
                : isLogin == false || isLogin == null
                    ? LoginPage.routeName
                    : MainPage.routeName,
            routes: {
              OnboardingPage.routeName: (context) => const OnboardingPage(),
              MainPage.routeName: (context) => const MainPage(),
              LoginPage.routeName: (context) => const LoginPage(),
              SetBalancePage.routeName: (context) => const SetBalancePage(),
              RegisterPage.routeName: (context) => const RegisterPage(),
              HomePage.routeName: (context) => const HomePage(),
              DetailIncomePage.routeName: (context) => const DetailIncomePage(),
              DetailExpensePage.routeName: (context) =>
                  const DetailExpensePage(),
            },
          );
        },
      ),
    );
  }
}
