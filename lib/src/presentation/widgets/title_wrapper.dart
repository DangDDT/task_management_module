import 'package:flutter/material.dart';

import '../../../core/core.dart';

class TitleWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  const TitleWrapper({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
          ),
          child: Text(
            ' $title:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: kTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        kGapH4,
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: child,
        ),
      ],
    );
  }
}
