import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:task_management_module/core/core.dart';

import '../../../../domain/models/task_event_reminder.dart';

class HorizontalListCardBuilder extends StatelessWidget {
  final List<TaskEventReminderModel> data;
  final Function(TaskEventReminderModel item, int index)? onTap;
  const HorizontalListCardBuilder({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _TaskEventLayoutBuilder(
      data: data,
      itemBuilder: (item, index) => GestureDetector(
        onTap: () => onTap?.call(item, index),
        child: _TaskEventItem(
          item: item,
          index: index,
        ),
      ),
    );
  }
}

class _TaskEventLayoutBuilder extends StatelessWidget {
  final List<TaskEventReminderModel> data;
  final Widget Function(TaskEventReminderModel item, int index) itemBuilder;
  const _TaskEventLayoutBuilder({
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: data.length,
      itemBuilder: (context, index, realIndex) => itemBuilder(
        data[index],
        index,
      ),
      options: CarouselOptions(
        height: 120,
        viewportFraction: .8,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: const Duration(seconds: 5),
      ),
    );
  }
}

class _TaskEventItem extends StatelessWidget {
  final TaskEventReminderModel item;
  final int index;
  const _TaskEventItem({
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: kTheme.colorScheme.primaryContainer.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: item.color,
                      ),
                      kGapW8,
                      Text(
                        item.isNotify
                            ? item.eventAt.toReadableDueDateWithHourString()
                            : item.eventAt.toReadableDueDateString(),
                        style: kTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (item.isNotify)
                    Icon(
                      Icons.notifications_active,
                      color: kTheme.colorScheme.primary,
                      size: 16,
                    ),
                ],
              ),
              kGapH8,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Nhắc nhở: ',
                      style: kTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kTheme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    TextSpan(
                      text: item.content,
                      style: kTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
