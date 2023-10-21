import 'dart:math';

import 'package:intl/intl.dart';

extension IntX on int {
  String numToReadableString() {
    return this < 10 && this > 0 ? "0$this" : toString();
  }

  String numToDoubleString() {
    return '$this.0';
  }

  String toMMss() {
    var formattedDuration = '';
    final minutes = this ~/ 60;
    final seconds = this % 60;

    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    formattedDuration = '$minutesStr:$secondsStr';
    return formattedDuration;
  }

  String toZeroPadString(int length) {
    return toString().padLeft(length, '0');
  }
}

extension IntNullExt on int? {
  String toVietNamCurrency() {
    return NumberFormat.currency(locale: 'vi', symbol: 'đ', decimalDigits: 0)
        .format(this);
  }

  String? toStringNotNull() {
    return this == null ? null : toString();
  }

  /// Convert number to vietnamese word by recursively divide number into 3 digits
  ///
  /// Example: 123487421.toWord() => Một trăm hai mươi ba triệu bốn trăm tám mươi bảy nghìn bốn trăm hai mươi một
  String toVietnameseWords() {
    if (this == null) {
      return 'Không';
    }
    if (this == 0) {
      return 'Không';
    }

    String s = toString().replaceAll('.', '');

    List<String> groups =
        (ZERO_LEFT_PADDING[s.length % 3] + s).chunk(3).toList();
    bool showZeroHundred = shouldShowZeroHundred(groups);

    int index = -1;
    String rawResult = groups.fold('', (String acc, String e) {
      index++;
      String triple = readTriple(e, showZeroHundred && index > 0);
      String multipleThousand = triple.trim().isEmpty
          ? ''
          : MULTIPLE_THOUSAND[groups.length - 1 - index];
      return '$acc $triple $multipleThousand';
    });

    return RegExp(r'\s+').allMatches(rawResult).isEmpty
        ? rawResult.trim().capitalize()
        : rawResult.replaceAll(RegExp(r'\s+'), ' ').trim().capitalize();
  }

  String toVietnameseCurrency() {
    return '${toVietnameseWords()} đồng';
  }
}

extension StringExtensions on String {
  Iterable<String> chunk(int chunkSize) sync* {
    for (int i = 0; i < length; i += chunkSize) {
      yield substring(i, min(i + chunkSize, length));
    }
  }

  String capitalize() {
    if (isEmpty) {
      throw 'Input cannot be empty';
    } else {
      return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
    }
  }
}

const List<String> ZERO_LEFT_PADDING = ["", "00", "0"];

const List<String> DIGITS = [
  "không",
  "một",
  "hai",
  "ba",
  "bốn",
  "năm",
  "sáu",
  "bảy",
  "tám",
  "chín"
];

const List<String> MULTIPLE_THOUSAND = [
  "",
  "nghìn",
  "triệu",
  "tỷ",
  "nghìn tỷ",
  "triệu tỷ",
  "tỷ tỷ"
];

bool shouldShowZeroHundred(List<String> goups) {
  List<String> reversedGroups = [...goups].reversed.toList();
  int count = reversedGroups.takeWhile((it) => it == "000").length;
  return count < reversedGroups.length - 1;
}

String readTriple(String triple, bool showZeroHundred) {
  List<int> digits = triple.split('').map(int.parse).toList();

  int a = digits[0];
  int b = digits[1];
  int c = digits[2];

  if (a == 0 && b == 0 && c == 0) {
    return "";
  } else if (a == 0 && showZeroHundred) {
    return "không trăm ${readPair(b, c)}";
  } else if (a == 0 && b == 0) {
    return DIGITS[c];
  } else if (a == 0) {
    return readPair(b, c);
  } else {
    return "${DIGITS[a]} trăm ${readPair(b, c)}";
  }
}

String readPair(int b, int c) {
  switch (b) {
    case 0:
      return c == 0 ? '' : 'linh ${DIGITS[c]}';
    case 1:
      switch (c) {
        case 0:
          return 'mười';
        case 5:
          return 'mười lăm';
        default:
          return 'mười ${DIGITS[c]}';
      }
    default:
      switch (c) {
        case 0:
          return '${DIGITS[b]} mươi ';
        case 1:
          return '${DIGITS[b]} mươi mốt';
        case 4:
          return '${DIGITS[b]} mươi tư';
        case 5:
          return '${DIGITS[b]} mươi lăm';
        default:
          return '${DIGITS[b]} mươi ${DIGITS[c]}';
      }
  }
}
