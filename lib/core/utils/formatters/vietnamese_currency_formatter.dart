import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class VietnameseCurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final int selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    final f = NumberFormat("#,###", "vi_VN");

    double value =
        double.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));

    final newString = f.format(value);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
