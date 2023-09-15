import 'package:flutter/material.dart';

class ResponsiveWidthWrapper extends StatelessWidget {
  final Widget child;
  const ResponsiveWidthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: width.clamp(100, 400),
      ),
      child: child,
    );
  }
}
