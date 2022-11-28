import 'package:flutter/material.dart';

import '../../core.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kWhite,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: SizedBox(
          height: 45,
          width: 45,
          child: Center(
            child: Image.asset("assets/icon_arrow_left.png", scale: 2),
          ),
        ),
      ),
    );
  }
}
