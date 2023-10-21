import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:task_management_module/core/core.dart';

class AddTaskReminderDialog extends StatefulWidget {
  final String? content;
  final bool? isNotify;
  final Color? color;
  final String title;
  final String addButtonText;
  final TimeOfDay? time;
  final Future<void> Function(
    String content,
    bool isNotify,
    Color color,
    bool isSync,
    TimeOfDay time,
  )? onSubmit;
  const AddTaskReminderDialog({
    super.key,
    this.content,
    this.isNotify,
    this.color,
    this.onSubmit,
    this.time,
    required this.title,
    required this.addButtonText,
  });

  @override
  State<AddTaskReminderDialog> createState() => _AddTaskReminderDialogState();
}

class _AddTaskReminderDialogState extends State<AddTaskReminderDialog> {
  late final TextEditingController _contentController;
  late TimeOfDay _time;
  late bool _isNotify;
  late bool _isSyncCalendar;
  late Color _color;

  @override
  void initState() {
    _contentController = TextEditingController(
      text: widget.content ?? '',
    );
    _time = widget.time ?? TimeOfDay.now();
    _isNotify = widget.isNotify ?? false;
    _isSyncCalendar = false;
    _color = widget.color ?? Colors.primaries[0];
    super.initState();
  }

  void _setNotify(bool value) {
    setState(() {
      _isNotify = value;
    });
  }

  void _setSyncCalendar(bool value) {
    setState(() {
      _isSyncCalendar = value;
    });
  }

  void _setColor(Color value) {
    setState(() {
      _color = value;
    });
  }

  void _setTime(TimeOfDay value) {
    setState(() {
      _time = value;
    });
  }

  Future<void> _onChangeColor() async {
    final colorPicked = await Get.dialog<Color?>(
      _ColorPickDialog(color: _color),
    );
    if (colorPicked != null) {
      _setColor(colorPicked);
    }
  }

  Future<void> _onChangeTime() async {
    final timePicked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (timePicked != null) {
      _setTime(timePicked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: AlertDialog(
        insetPadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.all(16),
        title: Text(widget.title),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    hintText: 'Nhập nội dung nhắc nhở',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    filled: true,
                    fillColor: kTheme.colorScheme.secondaryContainer,
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                ),
                kGapH8,
                CheckboxListTile(
                  value: _isNotify,
                  onChanged: (value) => _setNotify(value!),
                  title: const Text('Nhắc nhở'),
                  subtitle: const Text(
                    'Nhắc nhở sẽ được gửi đến bạn vào thời gian nhất định.',
                  ),
                ),
                if (_isNotify) ...[
                  ListTile(
                    title: const Text('Thời gian nhắc nhở'),
                    trailing: Text(
                      _time.format(context),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                    ),
                    onTap: _onChangeTime,
                  ),
                ],
                CheckboxListTile(
                  value: _isSyncCalendar,
                  onChanged: (value) => _setSyncCalendar(value!),
                  title: const Text('Đồng bộ với lịch'),
                  subtitle: const Text(
                    'Nhắc nhở sẽ được đồng bộ với lịch điện thoại của bạn.',
                  ),
                ),
                ListTile(
                  title: const Text('Màu sắc hiển thị'),
                  trailing: SizedBox(
                    width: 32,
                    height: 32,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onTap: _onChangeColor,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => widget.onSubmit?.call(
              _contentController.text,
              _isNotify,
              _color,
              _isSyncCalendar,
              _time,
            ),
            child: Text(widget.addButtonText),
          ),
        ],
      ),
    );
  }
}

class _ColorPickDialog extends StatefulWidget {
  final Color color;
  const _ColorPickDialog({required this.color});

  @override
  State<_ColorPickDialog> createState() => _ColorPickDialogState();
}

class _ColorPickDialogState extends State<_ColorPickDialog> {
  late Color _color;

  void _setColor(Color value) {
    setState(() {
      _color = value;
    });
  }

  @override
  void initState() {
    _color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(16),
      title: const Text('Chọn màu sắc'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.builder(
                shrinkWrap: true,
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () => _setColor(Colors.primaries[index]),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.primaries[index],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    if (_color == Colors.primaries[index])
                      const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _color),
          child: const Text('Chọn'),
        ),
      ],
    );
  }
}
