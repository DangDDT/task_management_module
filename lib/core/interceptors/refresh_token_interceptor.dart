import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_x_package;
import '../module_configs.dart';
import '../utils/helpers/logger.dart';

class RefreshTokenInterceptor implements Interceptor {
  static final ModuleConfig _config =
      get_x_package.Get.find(tag: ModuleConfig.tag);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await _config.getAuthConfig?.accessToken?.call();
      if (accessToken == null) return handler.next(options);
      options.headers['Authorization'] = 'Bearer $accessToken';
      options.headers['Accept'] = '*/*';
      return handler.next(options);
    } catch (error, stackTrace) {
      Logger.log(
        error.toString(),
        name: 'RefreshTokenInterceptor_onRequest',
        stackTrace: stackTrace,
      );
      return handler.next(options);
    }
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.response != null) {
      if (error.response!.statusCode == 401) {
        try {
          // final requestOptions = error.requestOptions;
          // final newAccessToken =
          //     await _config.getAuthConfig?.onRefreshTokenCallback?.call();
          // if (newAccessToken == null) return handler.next(error);
          // final opts = Options(method: requestOptions.method);
          // final dioClient = Dio();
          // dioClient.options.headers['Authorization'] = 'Bearer $newAccessToken';
          // dioClient.options.headers['Accept'] = '*/*';
          // final response = await dioClient.request<dynamic>(
          //   requestOptions.path,
          //   options: opts,
          //   cancelToken: requestOptions.cancelToken,
          //   onReceiveProgress: requestOptions.onReceiveProgress,
          //   data: requestOptions.data,
          //   queryParameters: requestOptions.queryParameters,
          // );
          return _config.getAuthConfig?.onUnauthorizedCallback?.call();
        } catch (e) {
          return handler.next(error);
        }
      } else {
        return handler.next(error);
      }
    }
    return handler.next(error);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) =>
      handler.next(response);
}
