import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int index;
  final String iconPath;

  const CustomBottomNavigation({
    Key? key,
    required this.index,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SetPage>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: context.watch<SetPage>().state == index ? kGreen : kGrey,
          ),
          Container(
            height: 3,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: context.watch<SetPage>().state == index ? kGreen : kWhite,
            ),
          ),
        ],
      ),
    );
  }
}
