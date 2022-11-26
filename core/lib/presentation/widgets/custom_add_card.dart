import 'package:flutter/material.dart';

import '../../core.dart';

class AddCard extends StatelessWidget {
  const AddCard({
    super.key,
    required this.iconPath,
    required this.subtitle,
    required this.textColor,
  });

  final String iconPath;
  final String subtitle;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 60,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Add", style: kHeading7.copyWith(color: textColor)),
                    Text(
                      subtitle,
                      style: kBodyText.copyWith(
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                Image.asset(iconPath, scale: 1.5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
