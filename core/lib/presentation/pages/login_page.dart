import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  onChanged: (query) {},
                  decoration: const InputDecoration(
                    hintText: 'Kata Sandi',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: kGrey)),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  textInputAction: TextInputAction.search,
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
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
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: kGreen),
                    child: const Text('Masuk'),
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
                  onTap: () {},
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
                        const Text(
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
                    const Text(
                      'Daftar',
                      style: TextStyle(
                        color: kGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
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
