import 'package:flutter/material.dart';
import 'package:task_management_module/core/core.dart';

class TextHighlightKeyword extends StatelessWidget {
  final String text;
  final String? keyword;
  final TextStyle? basicStyle;
  const TextHighlightKeyword({
    required this.text,
    required this.keyword,
    required this.basicStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (keyword == null || keyword!.isEmpty) {
      return Text(text, style: basicStyle);
    }
    return RichText(
      text: TextSpan(
        children: text.splitByKeyword(keyword!).map((e) {
          final isKeyword = e.removeDiacritics().toLowerCase() ==
              keyword?.toLowerCase().removeDiacritics();
          if (isKeyword) {
            return TextSpan(
              text: e,
              style: basicStyle?.copyWith(
                color: kTheme.colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            );
          }
          return TextSpan(text: e, style: basicStyle);
        }).toList(),
      ),
    );
  }
}
