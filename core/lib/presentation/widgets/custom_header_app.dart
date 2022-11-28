import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

class BackgroundHeader extends StatelessWidget {
  const BackgroundHeader({
    Key? key,
    required this.height,
    this.imagePath = 'assets/green_substract.png',
    this.color = kDarkGreen,
  }) : super(key: key);

  final double height;
  final String imagePath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.height;
    return Container(
      height: mediaQuery * height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
        ),
      ),
    );
  }
}
