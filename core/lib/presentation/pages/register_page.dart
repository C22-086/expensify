import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register_page';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool? _isAgree = false;
  bool _isPasswordShow = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signUpEmailAndPassword(context) {
    if (_emailController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Email belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (_passwordController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Password belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      BlocProvider.of<AuthBloc>(context).add(
        RegisterRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _signInWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleLogInRequested(),
    );
  }

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Text(
                      'Expensify',
                      style: kTitle,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Center(
                      child: Text(
                    'Buat Akun',
                    style: kHeading5,
                  )),
                  const SizedBox(height: 5),
                  Center(
                      child: Text(
                    'Mulai kelola keuangan anda sekarang!',
                    style: kBodyText,
                  )),
                  const SizedBox(height: 26),
                  Text(
                    'Email',
                    style: kHeading7,
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kGrey)),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Kata Sandi',
                    style: kHeading7,
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordShow,
                    decoration: InputDecoration(
                      hintText: 'Kata Sandi',
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: kGrey)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordShow = !_isPasswordShow;
                            });
                          },
                          icon: Icon(_isPasswordShow
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _isAgree,
                            onChanged: (value) {
                              setState(() {
                                _isAgree = value;
                              });
                            },
                          ),
                          Column(
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    'Saya menyutujui segala isi ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'syarat',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: kGreen),
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  Text(
                                    'penggunaan ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: kGreen),
                                  ),
                                  Text(
                                    'dan ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    'kebijakan privasi',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: kGreen),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return state is AuthLoading
                              ? ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kGreen),
                                  icon: Container(
                                    width: 24,
                                    height: 24,
                                    padding: const EdgeInsets.all(2.0),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                  label: const SizedBox(),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () {
                                    _signUpEmailAndPassword(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kGreen),
                                  icon: const SizedBox(),
                                  label: const Text('Daftar'),
                                );
                        },
                      )),
                  const SizedBox(height: 50),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('atau'),
                      SizedBox(width: 10),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      _signInWithGoogle(context);
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6)),
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.network(
                                  'http://pngimg.com/uploads/google/google_PNG19635.png',
                                  fit: BoxFit.cover),
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
                                  : const Text(
                                      'Masuk dengan Google',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                              const SizedBox(
                                width: 0,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah memiliki akun?',
                        style: kBodyText,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            color: kGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
