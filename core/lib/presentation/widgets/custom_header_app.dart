import 'package:flutter/cupertino.dart';

class BackgroundHeader extends StatelessWidget {
  const BackgroundHeader({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.height;
    return Container(
      height: mediaQuery * height,
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
    );
  }
}
