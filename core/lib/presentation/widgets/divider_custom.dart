import 'package:flutter/material.dart';

Widget dividerCustom() {
  return Row(
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
  );
}
