import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'fade_scale_transition_wrapper.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  const LoadingWidget({Key? key, this.message = "Đang tải dữ liệu"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeScaleTransitionWrapper(
      duration: const Duration(milliseconds: 610),
      child: SizedBox(
        height: 300,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              CircularProgressIndicator(color: kTheme.colorScheme.primary),
              kGapH16,
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
