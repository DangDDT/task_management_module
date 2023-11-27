// // ignore_for_file: public_member_api_docs, sort_constructors_first

import 'task_management_module.dart';

class ModuleConfig {
  static const String tag = '${TaskManagementModule.packageName}_ModuleConfig';
  ModuleConfig({
    this.isShowLog = false,
    required this.baseUrlConfig,
    this.onCreateLocalNotificationCallback,
  })  : _userConfig = null,
        _authConfig = null,
        tabsInTaskView = null,
        _myCategoryIdCallback = null;

  final bool isShowLog;

  final BaseUrlConfig baseUrlConfig;

  UserConfig? _userConfig;

  UserConfig get userConfig {
    if (_userConfig == null) {
      throw AssertionError("Bạn chưa đăng nhập để sử dụng chức năng này");
    }

    return _userConfig!;
  }

  set setUserConfig(UserConfig? userConfig) {
    _userConfig = userConfig;
  }

  ///[authConfig] là các config về auth của module
  ///[authConfig] là config để authen/authorize cho module
  AuthConfig? _authConfig;
  AuthConfig? get getAuthConfig => _authConfig;
  set setAuthConfig(AuthConfig? authConfig) => _authConfig = authConfig;

  // ModuleRole? _moduleRole;
  // ModuleRole get moduleRole {
  //   if (_moduleRole == null) {
  //     throw AssertionError("Bạn không có quyền để sử dụng chức năng này");
  //   }

  //   return _moduleRole!;
  // }

  // set setModuleRole(ModuleRole? moduleRole) => _moduleRole = moduleRole;

  OnCreateLocalNotifyCallback? onCreateLocalNotificationCallback;

  List<ListTaskTab>? tabsInTaskView;

  OnGetMyCategoryIdCallback? _myCategoryIdCallback;
  OnGetMyCategoryIdCallback? get getMyCategoryIdCallback =>
      _myCategoryIdCallback;
  set setGetMyCategoryCallback(
    OnGetMyCategoryIdCallback? myCategoryIdCallback,
  ) =>
      _myCategoryIdCallback = myCategoryIdCallback;
}

class BaseUrlConfig {
  final String baseUrl;

  BaseUrlConfig({
    required this.baseUrl,
  });
}

class UserConfig {
  final dynamic userId;
  final String fullName;
  final String avatar;
  const UserConfig({
    required this.userId,
    required this.fullName,
    required this.avatar,
  });
}

class AuthConfig {
  /// TODO: Thêm các trường dữ liệu cần thiết để thực hiện các chức năng cho module

  /// [accessToken] là callback được gọi để truyền accesstoken vào header của api
  final OnGetTokenCallback? accessToken;

  /// [onRefreshTokenCallback] là callback được gọi khi có lỗi xảy ra với api
  final OnRefreshTokenCallback? onRefreshTokenCallback;

  /// [onUnauthorizedCallback] là khi có lỗi 401 thì sẽ gọi callback này
  final OnUnauthorizedCallback? onUnauthorizedCallback;

  AuthConfig({
    this.accessToken,
    this.onRefreshTokenCallback,
    this.onUnauthorizedCallback,
  });
}

typedef OnGetTokenCallback = Future<String?> Function();
typedef OnRefreshTokenCallback = Future<String?> Function();
typedef OnUnauthorizedCallback = Future<void> Function();
typedef OnCreateLocalNotifyCallback = Future<void> Function(
  int id,
  String title,
  String body,
  DateTime at,
);
typedef OnGetMyCategoryIdCallback = Future<String> Function();
