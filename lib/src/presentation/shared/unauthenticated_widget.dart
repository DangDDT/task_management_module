import 'package:flutter/material.dart';

import '../../../core/core.dart';

class UnauthenticatedWidget extends StatelessWidget {
  final String message;
  const UnauthenticatedWidget({
    super.key,
    this.message = 'Bạn cần phải đăng nhập để có thể thực hiện chức năng này',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Icon(
            Icons.warning,
            color: Colors.orange,
            size: 32,
          ),
          kGapH12,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
