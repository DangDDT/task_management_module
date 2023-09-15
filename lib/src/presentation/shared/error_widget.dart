import 'package:flutter/material.dart';

import '../../../core/core.dart';
import 'fade_scale_transition_wrapper.dart';

class ErrorOrEmptyWidget extends StatelessWidget {
  final String message;
  final String? content;
  final VoidCallback? callBack;
  final double height;
  const ErrorOrEmptyWidget({
    Key? key,
    this.message = "Không có dữ liệu",
    this.content,
    this.callBack,
    this.height = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeScaleTransitionWrapper(
      child: SizedBox(
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (content != null) ...[
                kGapH12,
                Text(
                  content!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              if (callBack != null) ...[
                kGapH12,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kTheme.colorScheme.primary,
                  ),
                  onPressed: callBack,
                  child: const Text("Thử lại"),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
