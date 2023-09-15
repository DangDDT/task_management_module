// ignore_for_file: empty_catches

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class CircleAvatarWithErrorHandler extends StatefulWidget {
  const CircleAvatarWithErrorHandler({
    super.key,
    required this.avatarUrl,
    required this.fullName,
    this.radius = 12,
  });
  final String? avatarUrl;
  final String? fullName;
  final double radius;

  @override
  State<CircleAvatarWithErrorHandler> createState() =>
      _CircleAvatarWithErrorHandlerState();
}

class _CircleAvatarWithErrorHandlerState
    extends State<CircleAvatarWithErrorHandler> {
  bool isAvatarLoadError = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primary.withOpacity(.8);
    TextStyle? textStyle = kTheme.textTheme.bodyMedium?.copyWith(
      color: backgroundColor.textColor,
    );
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: backgroundColor,
      backgroundImage: widget.avatarUrl != null
          ? BaseExtendedImageNetwork(imageUrl: widget.avatarUrl!).image
          : null,
      onBackgroundImageError: widget.avatarUrl != null
          ? (exception, stackTrace) {
              try {
                if (!isAvatarLoadError) {
                  setState(() {
                    isAvatarLoadError = true;
                  });
                }
              } catch (e) {}
            }
          : null,
      child: (widget.avatarUrl == null || isAvatarLoadError)
          ? Center(
              child: Text(
                widget.fullName!.initialWords.toUpperCase(),
                style: textStyle?.copyWith(
                  fontSize: widget.radius / 1.3,
                ),
              ),
            )
          : null,
    );
  }
}

class BaseExtendedImageNetwork extends ExtendedImage {
  BaseExtendedImageNetwork({
    super.key,
    required String imageUrl,
  }) : super.network(
          imageUrl,
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case LoadState.completed:
                return null;
              case LoadState.failed:
                return const Center(
                  child: Icon(Icons.error),
                );
            }
          },
          fit: BoxFit.cover,
          cacheMaxAge: const Duration(minutes: 1),
          clearMemoryCacheWhenDispose: true,
          clearMemoryCacheIfFailed: true,
        );
}
