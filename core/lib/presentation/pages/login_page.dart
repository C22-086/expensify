import 'package:core/core.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _isAgree = false;
  bool _isPasswordShow = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainPage(),
                ),
              );
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
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
                      subHeading: 'Silahkan masuk untuk melanjutkan',
                    )),
                    TextFormEmail(controller: _emailController),
                    const SizedBox(height: 15),
                    TextFormPassword(
                      passwordController: _passwordController,
                      isPasswordShow: _isPasswordShow,
                      onPressed: () {
                        setState(() {
                          _isPasswordShow = !_isPasswordShow;
                        });
                      },
                    ),
                    const SizedBox(height: 7),
                    CheckBoxLogIn(
                      isAgree: _isAgree,
                      onChanged: (value) {
                        setState(() {
                          _isAgree = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    buttonLogIn(),
                    const SizedBox(height: 15),
                    buttonLogInWithGoogle(),
                    const SizedBox(height: 30),
                    LogInQuestion(
                      text: 'Belum punya akun?',
                      buttonText: 'Daftar',
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RegisterPage.routeName,
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonLogIn() {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state is AuthLoading
              ? const CustomLoadingButton()
              : CustomButton(
                  title: "Masuk",
                  onPressed: () async {
                    _signInEmailAndPassword(context);
                  },
                );
        },
      ),
    );
  }

  Widget buttonLogInWithGoogle() {
    return InkWell(
      onTap: () {
        _signInWithGoogle(context);
      },
      child: Container(
        height: defaultButtonHeight,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/icon_google.png',
                  scale: 2,
                ),
                state is AuthLoadingGoogle
                    ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(
                          color: kGreen,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        'Masuk dengan Google',
                        style: kHeading7,
                      ),
                const SizedBox(
                  width: 0,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _signInEmailAndPassword(context) async {
    if (_emailController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Email belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (_passwordController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Password belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      BlocProvider.of<AuthBloc>(context).add(
        LogInRequested(
            email: _emailController.text, password: _passwordController.text),
      );
      final pref = await SharedPreferences.getInstance();
      pref.setBool('isLogin', true);
    }
  }

  void _signInWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleLogInRequested(),
    );
  }
}
