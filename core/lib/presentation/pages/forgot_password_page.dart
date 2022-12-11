// ignore_for_file: use_build_context_synchronously

import 'package:core/presentation/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = '/forgot-password';

  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (_emailController.text.isNotEmpty) {
      try {
        await auth.sendPasswordResetEmail(email: _emailController.text);
        _emailController.text = '';
        const snackbar = SnackBar(
          content: Text(
              'Berhasil mengirimkan email reset password, coba perikasa email kamu'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      } on FirebaseAuthException catch (e) {
        var snackbar = SnackBar(content: Text("$e"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } else {
      const snackbar = SnackBar(content: Text('Email belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: TitlePage(
                      subHeading:
                          'Silahkan memasukan email untuk melakukan reset kata sandi anda',
                    ),
                  ),
                  const SizedBox(height: 45),
                  TextFormEmail(controller: _emailController),
                  const SizedBox(height: 45),
                  CustomButton(
                    title: "Kirim",
                    onPressed: () {
                      sendEmail();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
