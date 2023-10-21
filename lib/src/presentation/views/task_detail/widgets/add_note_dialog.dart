import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditNoteDialog extends StatefulWidget {
  final String title;
  final String? initialContent;
  const AddEditNoteDialog({
    super.key,
    this.initialContent,
    required this.title,
  });

  @override
  State<AddEditNoteDialog> createState() => _AddEditNoteDialogState();
}

class _AddEditNoteDialogState extends State<AddEditNoteDialog> {
  late final TextEditingController _textEditingController =
      TextEditingController(
    text: widget.initialContent,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'Nhập ghi chú',
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  Get.back(result: _textEditingController.text);
                },
                child: const Text('Thêm'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
