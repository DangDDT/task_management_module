part of 'string_ext.dart';

extension StringRegex on String {
  /// Không chứa ký tự đặc biệt bao gồm cả /,.()*
  bool get isVietNamesePlainText {
    return isNotIncludeSpecialStrongDigit && isNotEmoji;
  }

  /// Không chứa ký tự đặc biệt nhưng được phép có /,.()*-_? và khoảng trắng
  bool get isVietnamNormalSentence {
    return isNotIncludeSpecialSoftDigit && isNotEmoji;
  }

  bool get isNotIncludeSpecialStrongDigit {
    return _hasMatch(this, _notSpecialRegexStrong.pattern);
  }

  bool get isNotIncludeSpecialSoftDigit {
    return _hasMatch(this, _notSpecialRegexSoft.pattern);
  }

  bool get isNotEmoji {
    return !_hasMatch(this, _emojiRegex.pattern);
  }

  ///Detect if String is a valid phone number
  static bool isPhoneNumber(String s) {
    if (s.length > 11 || s.length < 10) return false;
    return _hasMatch(s, r'(84|0[2|3|5|7|8|9])+([0-9]{7,9})');
  }

  static bool _hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
}

final RegExp _notSpecialRegexStrong = RegExp(r'^[^!@#<>?\":_`~;[\]\\|=+)(*&^%-\/,.;]*$');

final RegExp _notSpecialRegexSoft = RegExp(r'^[^!@#<>\":`~;[\]\\|=&^%$]*$');

final RegExp _emojiRegex =
    RegExp('(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
