import 'package:flutter/material.dart';

class DotsIndicator extends StatefulWidget {
  final Color backgroundColor;
  const DotsIndicator({required this.backgroundColor, super.key});

  @override
  State<DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<DotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 30,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
