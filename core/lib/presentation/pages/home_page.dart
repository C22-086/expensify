import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/green_substract.png'),
              fit: BoxFit.cover,
            ),
            color: Color(0xff1F8B4E),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
            ),
          ),
          child: Row(children: [
            Column(
              children: [
                Image.asset('assets/icon_wallet.png'),
              ],
            )
          ]),
        ),
      ],
    ));
  }
}
