import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetBalancePage extends StatelessWidget {
  static const routeName = '/set-balance';

  const SetBalancePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController balanceController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Expensify',
                style: kTitle,
              ),
              const SizedBox(height: 20),
              Text('Set Saldo Awal', style: kHeading5),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 13,
                inputFormatters: const [],
                controller: balanceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  icon: Text(
                    'Rp',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  labelText: 'Saldo Kamu',
                  hintText: 'Masukkan Saldo Kamu',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final ref = FirebaseDatabase.instance
                      .ref()
                      .child('users/${FirebaseAuth.instance.currentUser!.uid}');

                  await ref
                      .update({'balance': int.parse(balanceController.text)});

                  navigator.pushReplacement(MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ));
                },
                child: Text(
                  'Set Saldo',
                  style: GoogleFonts.poppins(
                    color: kWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
