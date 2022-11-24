import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isLoadingGoogle = false;
  bool? _isAgree = false;
  bool _isPasswordShow = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                  'Selamat Datang',
                  style: kHeading5,
                )),
                const SizedBox(height: 5),
                Center(
                    child: Text(
                  'Silahkan masuk untuk melanjutkan',
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
                  onChanged: (query) {},
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
                  onChanged: (query) {},
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
                        Text(
                          'Ingat saya',
                          style: kBodyText,
                        ),
                      ],
                    ),
                    Text(
                      'Lupa kata sandi?',
                      style: kBodyText,
                    )
                  ],
                ),
                const SizedBox(height: 22),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        final navigator = Navigator.of(context);
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        if (email.isEmpty) {
                          const snackbar =
                              SnackBar(content: Text('Email belum di isi'));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else if (password.isEmpty) {
                          const snackbar =
                              SnackBar(content: Text('Password belum di isi'));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else {
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          navigator.pushNamed(HomePage.routeName);
                        }
                      } catch (e) {
                        final snackbar = SnackBar(content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      } finally {
                        _isLoading = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: kGreen),
                    icon: _isLoading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const SizedBox(),
                    label: _isLoading ? const SizedBox() : const Text('Masuk'),
                  ),
                ),
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
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    setState(() {
                      _isLoadingGoogle = true;
                    });

                    try {
                      if (FirebaseAuth.instance.currentUser == null) {
                        GoogleSignInAccount? account =
                            await GoogleSignIn().signIn();

                        if (account != null) {
                          GoogleSignInAuthentication auth =
                              await account.authentication;
                          OAuthCredential credential =
                              GoogleAuthProvider.credential(
                                  accessToken: auth.accessToken,
                                  idToken: auth.idToken);

                          await FirebaseAuth.instance
                              .signInWithCredential(credential);

                          navigator.pushNamed(HomePage.routeName);
                        }
                      }
                    } catch (e) {
                      final snackbar = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } finally {
                      _isLoadingGoogle = false;
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            fit: BoxFit.cover),
                        _isLoadingGoogle
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
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum memiliki akun?',
                      style: kBodyText,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.routeName);
                      },
                      child: const Text(
                        'Daftar',
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
    );
  }
}
