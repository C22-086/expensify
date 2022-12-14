import 'package:core/core.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:core/presentation/widgets/general_form.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
            if (state is Registered) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SetBalancePage(),
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
                        subHeading: 'Mulai kelola keuangan anda sekarang!',
                      ),
                    ),
                    GeneralForm(
                      controller: _nameController,
                      label: 'Full name',
                      hint: 'Full name',
                      textInputType: TextInputType.name,
                      icon: const Icon(Icons.person_outline),
                    ),
                    const SizedBox(height: 10),
                    TextFormEmail(controller: _emailController),
                    const SizedBox(height: 10),
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
                    CheckBoxRegister(
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
                    buttonRegister(),
                    const SizedBox(height: 15),
                    LogInQuestion(
                      text: 'Sudah punya akun?',
                      buttonText: 'Masuk',
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.routeName);
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

  Widget buttonRegister() {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state is AuthLoading
              ? const CustomLoadingButton()
              : CustomButton(
                  title: "Daftar",
                  onPressed: () {
                    _signUpEmailAndPassword(context);
                  },
                );
        },
      ),
    );
  }

  void _signUpEmailAndPassword(context) {
    if (_emailController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Email belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (_passwordController.text.isEmpty) {
      const snackbar = SnackBar(content: Text('Password belum di isi'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      BlocProvider.of<AuthBloc>(context).add(
        RegisterRequested(0,
            email: _emailController.text,
            name: _nameController.text,
            password: _passwordController.text),
      );
    }
  }
}
