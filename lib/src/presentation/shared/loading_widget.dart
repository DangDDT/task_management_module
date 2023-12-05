import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management_module/core/gens/assets.dart';
import 'package:task_management_module/src/presentation/shared/loading_text.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                Assets
                    .task_management_module$assets_animations_loading_find_task_json,
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 16),
              const LoadingText(
                placeholder: 'Đang tải dữ liệu',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
