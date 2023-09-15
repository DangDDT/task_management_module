import 'package:flutter/material.dart';

import '../../../core/core.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    this.isLoading = false,
    this.label = 'Loading Button',
  });

  final bool isLoading;
  final String label;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 410),
      curve: Curves.decelerate,
      width: isLoading ? width * 0.15 : width.clamp(100, 400),
      height: 48,
      decoration: BoxDecoration(
        color: kTheme.colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: kTheme.colorScheme.onPrimary,
                ),
              )
            : Text(
                label,
                style: kTheme.textTheme.titleMedium?.copyWith(
                  color: kTheme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
