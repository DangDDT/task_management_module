library vay_von_package;

import 'package:get/get.dart';

import '../src/infrastructure/local_databases/isar/isar_database.dart';
import 'core.dart';

export '../src/presentation/views/public_view.dart';

class TaskManagementModule {
  static const packageName = "task-management-module-$version";
  static const version = "1.0.0";
  static List<GetPage<dynamic>> get pageRoutes => ModuleRouter.routes;
  static TranslateManager get l10n => TranslateManager();

  static bool _isInitialized = false;

  static Future<void> init({
    bool isShowLog = false,
    required BaseUrlConfig baseUrlConfig,
    AuthConfig? authConfig,
    OnCreateLocalNotifyCallback? onCreateLocalNotificationCallback,
  }) async {
    await IsarDatabase.init();

    await GlobalBinding.setUpLocator(
        isShowLog: isShowLog,
        baseUrlConfig: baseUrlConfig,
        onCreateLocalNotificationCallback: onCreateLocalNotificationCallback);
    _isInitialized = true;
  }

  static void _assertInitialized() {
    if (!_isInitialized) {
      throw AssertionError(
        'UserModule is not initialized. Please call UserModule.init() before using any methods of UserModule.',
      );
    }
  }

  static Future<void> login(
      {required UserConfig userConfig, AuthConfig? authConfig}) async {
    _assertInitialized();
    Get.find<ModuleConfig>(tag: ModuleConfig.tag).setUserConfig = userConfig;
    Get.find<ModuleConfig>(tag: ModuleConfig.tag).setAuthConfig = authConfig;
  }

  static Future<void> logout() async {
    _assertInitialized();
    Get.find<ModuleConfig>(tag: ModuleConfig.tag).setUserConfig = null;
    Get.find<ModuleConfig>(tag: ModuleConfig.tag).setAuthConfig = null;
  }
}
