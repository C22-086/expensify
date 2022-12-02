import 'package:core/core.dart';
import 'package:core/presentation/pages/onboarding_page.dart';
import 'package:expensify/firebase_options.dart';
import 'package:expensify/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? initializeApp;
bool? isLogin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expensify',
        theme: ThemeData(colorScheme: kColorScheme),
        navigatorObservers: [routeObserver],
        initialRoute: initializeApp == false || initializeApp == null
            ? OnboardingPage.routeName
            : isLogin == false || isLogin == null
                ? LoginPage.routeName
                : MainPage.routeName,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case OnboardingPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const OnboardingPage(),
              );
            case MainPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const MainPage(),
              );
            case LoginPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
              );
            case SetBalancePage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SetBalancePage(),
              );

            case RegisterPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const RegisterPage(),
              );
            case HomePage.routeName:
              return MaterialPageRoute(
                builder: (_) => const HomePage(),
              );
            case AddIncomePage.routeName:
              return MaterialPageRoute(
                builder: (_) => const AddIncomePage(),
              );
            case DetailIncomePage.routeName:
              return MaterialPageRoute(
                builder: (_) => const DetailIncomePage(),
              );
            case DetailExpensePage.routeName:
              return MaterialPageRoute(
                builder: (_) => const DetailExpensePage(),
              );
            case EditProfilePage.routeName:
              return MaterialPageRoute(
                builder: (_) => EditProfilePage(
                  user: settings.arguments,
                ),
              );
            case ExportDataPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const ExportDataPage(),
              );

            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
