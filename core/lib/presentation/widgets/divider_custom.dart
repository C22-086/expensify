import 'package:core/core.dart';
import 'package:flutter/material.dart';

Widget dividerCustom() {
  return Row(
    children: [
      const Expanded(
        child: Divider(
          indent: 10,
          color: Colors.grey,
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'atau',
        style: kSubtitle,
      ),
      const SizedBox(width: 10),
      const Expanded(
        child: Divider(
          endIndent: 10,
          color: Colors.grey,
        ),
      ),
    ],
  );
}
