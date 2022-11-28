import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';

class CustomeCategory extends StatelessWidget {
  const CustomeCategory({
    Key? key,
    required this.title,
    required this.index,
    this.titleColor = kGreen,
  }) : super(key: key);

  final String title;
  final int index;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SetCategory>().setCategory(index);
      },
      child: Text(
        "Last Year",
        style: kHeading7.copyWith(
          color:
              context.watch<SetCategory>().state == index ? titleColor : kGrey,
        ),
      ),
    );
  }
}
