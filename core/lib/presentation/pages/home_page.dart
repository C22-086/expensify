import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              GoogleSignIn().signOut();
              await auth.signOut();
              navigator.pushReplacementNamed('/home');
            },
            style: ElevatedButton.styleFrom(backgroundColor: kGreen),
            child: const Text('Logout'),
          ),
        ),
      ),
    );
  }
}
