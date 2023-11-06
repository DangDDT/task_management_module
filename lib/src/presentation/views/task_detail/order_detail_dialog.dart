import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_preview/image_preview.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/models/task_order_detail.dart';

class OrderDetailDialog extends StatelessWidget {
  final TaskOrderDetailModel orderDetail;
  const OrderDetailDialog({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: const Text('Chi tiết đơn hàng'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderDetail.service.name,
                  style: kTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kGapH8,
                Row(
                  children: [
                    ...orderDetail.service.images
                        .take(4)
                        .map(
                          (e) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: GestureDetector(
                              onTap: () {
                                openImagesPage(
                                  Navigator.of(context),
                                  imgUrls: orderDetail.service.images,
                                );
                              },
                              child: ExtendedImage.network(
                                e,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList()
                        .joinWidget(kGapW8),
                    if (orderDetail.service.images.length > 4) ...[
                      kGapW8,
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '+${orderDetail.service.images.length - 4}',
                            style: kTheme.textTheme.titleMedium?.copyWith(
                              color: kTheme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            kGapH8,
            Text(
              orderDetail.service.description,
              style: kTheme.textTheme.bodyMedium,
            ),
            const Divider(),
            kGapH8,
            _RowData(
              title: 'Ngày thực hiện',
              content: orderDetail.eventDate.toFullString(),
            ),
            kGapH4,
            _RowData(
              title: 'Tổng tiền cung cấp',
              content: orderDetail.totalPrice.toInt().toVietNamCurrency(),
            ),
            kGapH4,
            _RowData(
              title: 'Phần trăm chiết khấu',
              content: '${orderDetail.commission.toString()} %',
              contentStyle: kTheme.textTheme.titleMedium?.copyWith(
                color: kTheme.colorScheme.onBackground.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            kGapH4,
            _RowData(
              title: 'Tiền chiết khấu',
              content:
                  ' - ${orderDetail.totalCommission.toInt().toVietNamCurrency()}',
              contentStyle: kTheme.textTheme.titleMedium?.copyWith(
                color: kTheme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            kGapH4,
            const Divider(),
            _RowData(
              title: 'Doanh thu',
              content: orderDetail.revenue.toInt().toVietNamCurrency(),
              contentStyle: kTheme.textTheme.titleMedium?.copyWith(
                color: kTheme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            kGapH28,
            Text.rich(
              TextSpan(
                text: 'Ghi chú: ',
                style: kTheme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: orderDetail.description,
                    style: kTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Đóng'),
        ),
      ],
    );
  }
}

class _RowData extends StatelessWidget {
  const _RowData({
    required this.title,
    required this.content,
    this.contentStyle,
  });
  final String title;
  final String content;
  final TextStyle? contentStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$title:'),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Text(
            content,
            style: contentStyle ??
                kTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
