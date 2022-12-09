import 'package:flutter/material.dart';

class NoOverviewCard extends StatelessWidget {
  const NoOverviewCard({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline),
            const SizedBox(height: 10),
            Text('Tidak ada data $title'),
          ],
        ),
      ),
    );
  }
}
