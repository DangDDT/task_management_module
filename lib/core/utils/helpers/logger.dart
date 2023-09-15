import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:talker/talker.dart';

import '../../module_configs.dart';

class Logger {
  static final ModuleConfig _moduleConfig =
      Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  static final TalkerLoggerSettings _settings = TalkerLoggerSettings(
    colors: {
      LogLevel.info: AnsiPen()..white(),
      LogLevel.warning: AnsiPen()..yellow(),
      LogLevel.error: AnsiPen()..red(),
      LogLevel.critical: AnsiPen()..rgb(r: 255, g: 165, b: 0),
    },
  );

  static final _talker = Talker(
    logger: TalkerLogger(
      settings: _settings,
    ),
  );

  static const String _tag = '${ModuleConfig.tag}_Logger';

  static String getLogMessage(String message, String code) {
    final logCode = "🚨 [$_tag|$code]";
    return "$logCode|$message";
  }

  static void log(
    String message, {
    Object? error,
    String? name,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _moduleConfig.isShowLog) {
      final logMessage = getLogMessage(message, name ?? "LOG");
      _talker.error(
        logMessage,
        error,
        stackTrace,
      );
    }
    return;
  }

  static logInfo(
    String message, {
    String name = "LOG",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _moduleConfig.isShowLog) {
      final logMessage = "[$_tag|$name]|$message";
      _talker.info(
        logMessage,
        exception,
        stackTrace,
      );
    }
    return;
  }

  static logCritical(
    String message, {
    String name = "LOG",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _moduleConfig.isShowLog) {
      final logMessage = "❌ [$_tag|$name]|$message";
      _talker.critical(
        logMessage,
        exception,
        stackTrace,
      );
    }
    return;
  }

  static logWarning(
    String message, {
    String name = "LOG",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _moduleConfig.isShowLog) {
      final logMessage = "⚠️ [$_tag|$name]|$message";
      _talker.warning(
        logMessage,
        exception,
        stackTrace,
      );
    }
    return;
  }

  static logOK(
    String message, {
    String name = "LOG",
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode && _moduleConfig.isShowLog) {
      final logMessage = "✅ [$_tag|$name]|$message";
      _talker.good(
        logMessage,
        exception,
        stackTrace,
      );
    }
    return;
  }
}
