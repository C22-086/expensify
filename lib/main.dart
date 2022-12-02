import 'package:core/core.dart';
import 'package:expensify/firebase_options.dart';
import 'package:expensify/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Expensify',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
    ),
  );

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expensify',
        theme: ThemeData(colorScheme: kColorScheme),
        navigatorObservers: [routeObserver],
        home: const LoginPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
              );
            case SetBalancePage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SetBalancePage(),
              );
            case LoginPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
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
                builder: (_) => const EditProfilePage(),
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
