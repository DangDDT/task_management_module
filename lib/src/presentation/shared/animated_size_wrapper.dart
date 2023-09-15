import 'package:flutter/material.dart';

class AnimatedSizeWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const AnimatedSizeWrapper({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 210),
  }) : super(key: key);

  @override
  State<AnimatedSizeWrapper> createState() => _AnimatedSizeWrapperState();
}

class _AnimatedSizeWrapperState extends State<AnimatedSizeWrapper>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.easeIn,
      duration: widget.duration,
      alignment: Alignment.topCenter,
      child: widget.child,
    );
  }
}
