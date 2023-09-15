// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../domain/enums/private/loading_enum.dart';
import 'base_shimmer.dart';

typedef LayoutBuilder<T extends List<E>, E> = Widget Function(
  T data,
  _Item<T, E> Function(
    E item,
    int index,
  ) itemBuilder,
);

typedef ItemBuilder<E> = Widget Function(
  E item,
  int index,
);

class StateRender<T extends List<E>, E> extends StatelessWidget {
  const StateRender({
    super.key,
    required this.state,
    required this.data,
    required this.layoutBuilder,
    required this.itemBuilder,
    this.isAnimation = false,
    this.verticalSlideOffset = 50.0,
    this.horizontalSlideOffset = 50.0,
    this.duration = const Duration(milliseconds: 410),
  });

  final LoadingState state;
  final T data;
  final LayoutBuilder<T, E> layoutBuilder;
  final ItemBuilder<E> itemBuilder;
  final bool isAnimation;
  final double verticalSlideOffset;
  final double horizontalSlideOffset;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case LoadingState.initial:
      case LoadingState.loading:
        return _LoadingView<T, E>(
          data: data,
          itemBuilder: itemBuilder,
          layoutBuilder: layoutBuilder,
        );
      case LoadingState.success:
        return _DataView<T, E>(
          layoutBuilder: layoutBuilder,
          itemBuilder: itemBuilder,
          data: data,
          isAnimation: isAnimation,
          verticalSlideOffset: verticalSlideOffset,
          horizontalSlideOffset: horizontalSlideOffset,
          duration: duration,
        );
      case LoadingState.empty:
      case LoadingState.error:
        return _ErrorView<T, E>(
          itemBuilder: itemBuilder,
          layoutBuilder: layoutBuilder,
          data: data,
        );
    }
  }
}

class _LoadingView<T extends List<E>, E> extends StatelessWidget {
  const _LoadingView({
    Key? key,
    required this.data,
    required this.layoutBuilder,
    required this.itemBuilder,
  });

  final T data;
  final LayoutBuilder<T, E> layoutBuilder;
  final ItemBuilder<E> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return _Layout<T, E>(
      isLoading: true,
      data: data,
      layoutBuilder: (data, itemBuilder) => AnimationLimiter(
        child: layoutBuilder(data, itemBuilder),
      ),
      itemBuilder: (item, index) => AnimationConfiguration.staggeredList(
        position: 0,
        duration: const Duration(milliseconds: 0),
        child: GestureDetector(
          onTap: () {},
          child: _Item<T, E>(
            data: data,
            item: item,
            isLoading: true,
            builder: itemBuilder,
          ),
        ),
      ),
    );
  }
}

class _DataView<T extends List<E>, E> extends StatelessWidget {
  const _DataView({
    Key? key,
    required this.data,
    required this.layoutBuilder,
    required this.itemBuilder,
    this.isAnimation = false,
    this.verticalSlideOffset = 50.0,
    this.horizontalSlideOffset = 50.0,
    this.duration = const Duration(milliseconds: 410),
  });

  final T data;
  final LayoutBuilder<T, E> layoutBuilder;
  final ItemBuilder<E> itemBuilder;
  final bool isAnimation;
  final double verticalSlideOffset;
  final double horizontalSlideOffset;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return _Layout<T, E>(
      data: data,
      isLoading: false,
      layoutBuilder: (data, itemBuilder) => AnimationLimiter(
        child: layoutBuilder(data, itemBuilder),
      ),
      itemBuilder: (item, index) => AnimationConfiguration.staggeredList(
        position: isAnimation ? index : 0,
        duration: isAnimation ? duration : const Duration(milliseconds: 0),
        child: FadeInAnimation(
          child: SlideAnimation(
            verticalOffset: verticalSlideOffset,
            horizontalOffset: horizontalSlideOffset,
            child: _Item<T, E>(
              data: data,
              item: item,
              isLoading: false,
              builder: itemBuilder,
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorView<T extends List<E>, E> extends StatelessWidget {
  const _ErrorView({
    Key? key,
    required this.data,
    required this.layoutBuilder,
    required this.itemBuilder,
  });

  final T data;
  final LayoutBuilder<T, E> layoutBuilder;
  final ItemBuilder<E> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return _Layout<T, E>(
        data: data,
        isLoading: false,
        layoutBuilder: (data, itemBuilder) => AnimationLimiter(
              child: layoutBuilder(data, itemBuilder),
            ),
        itemBuilder: (item, index) => AnimationConfiguration.staggeredList(
              position: 0,
              duration: const Duration(milliseconds: 0),
              child: GestureDetector(
                onTap: () {},
                child: _Item<T, E>(
                  data: data,
                  item: item,
                  isLoading: false,
                  builder: itemBuilder,
                ),
              ),
            ));
  }
}

class _Layout<T extends List<E>, E> extends StatelessWidget {
  final bool isLoading;
  final T data;
  final LayoutBuilder<T, E> layoutBuilder;
  final ItemBuilder<E> itemBuilder;
  const _Layout({
    Key? key,
    required this.isLoading,
    required this.data,
    required this.layoutBuilder,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return layoutBuilder(
      data,
      (item, index) => _Item<T, E>(
        data: data,
        item: item,
        isLoading: isLoading,
        builder: itemBuilder,
      ),
    );
  }
}

class _Item<T extends List<E>, E> extends StatelessWidget {
  final T data;
  final E item;
  final bool isLoading;
  final ItemBuilder<E> builder;
  const _Item({
    super.key,
    required this.data,
    required this.item,
    required this.builder,
    required this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? BaseShimmer(
            child: builder(
            item,
            data.indexOf(item),
          ))
        : builder(
            item,
            data.indexOf(item),
          );
  }
}
