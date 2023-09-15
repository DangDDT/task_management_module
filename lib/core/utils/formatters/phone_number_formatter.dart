import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final int selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    final newString = _formatPhoneNumber(newValue.text);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }

  /// Formatter for Vietnamese phoneNumber
  /// Example: 0918123456 return 0918 123 456
  String _formatPhoneNumber(String phoneNumber) {
    final String newString = phoneNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    final StringBuffer result = StringBuffer();
    for (int i = 0; i < newString.length; i++) {
      if (i == 4 || i == 7) {
        result.write(' ');
      }
      result.write(newString[i]);
    }
    return result.toString();
  }
}
