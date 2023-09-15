import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/constants/default_http_status_code_constants.dart';
import '../../exceptions/exceptions.dart';
import '../api_mappers/base/base_error_response_mapper.dart';

class DioErrorMapper extends ExceptionMapper<RemoteException> {
  DioErrorMapper(this._errorResponseMapper);

  final BaseErrorResponseMapper _errorResponseMapper;

  @override
  RemoteException map(Object? exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.cancel:
          return const RemoteException(kind: RemoteExceptionKind.cancellation);
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return RemoteException(
            kind: RemoteExceptionKind.timeout,
            rootException: exception,
          );
        case DioExceptionType.badResponse:
          final httpErrorCode = exception.response?.statusCode ?? -1;

          /// server-defined error
          if (exception.response?.data != null) {
            final serverError = exception.response!.data! is Map
                ? _errorResponseMapper.mapFromResponse(
                    exception.response!.data!,
                  )
                : ServerError(generalMessage: exception.response!.data!);

            if (httpErrorCode ==
                DefaultHttpStatusCodeConstants.unprocessableEntity) {
              return UnprocessableEntityRemoteException(
                httpErrorCode: httpErrorCode,
                serverError: serverError,
              );
            }

            if (httpErrorCode == DefaultHttpStatusCodeConstants.notFound) {
              return NotFoundRemoteException(
                httpErrorCode: httpErrorCode,
                serverError: serverError,
              );
            }

            if (httpErrorCode == DefaultHttpStatusCodeConstants.unauthorized) {
              return UnauthorizedRemoteException(
                httpErrorCode: httpErrorCode,
                serverError: serverError,
              );
            }

            if (httpErrorCode == DefaultHttpStatusCodeConstants.badRequest) {
              return RemoteException(
                kind: RemoteExceptionKind.badRequest,
                httpErrorCode: httpErrorCode,
                serverError: serverError,
              );
            }

            if (httpErrorCode == DefaultHttpStatusCodeConstants.unauthorized) {
              return RemoteException(
                kind: RemoteExceptionKind.unauthorized,
                httpErrorCode: httpErrorCode,
                serverError: serverError,
              );
            }

            if (httpErrorCode == DefaultHttpStatusCodeConstants.forbidden) {
              return RemoteException(
                kind: RemoteExceptionKind.forbidden,
                httpErrorCode: httpErrorCode,
                serverError: serverError,
              );
            }

            if (httpErrorCode ==
                DefaultHttpStatusCodeConstants.internalServerError) {
              return RemoteException(
                kind: RemoteExceptionKind.internalServerError,
                httpErrorCode: httpErrorCode,
                serverError: serverError,
              );
            }

            if (httpErrorCode == DefaultHttpStatusCodeConstants.unauthorized) {
              return RemoteException(
                kind: RemoteExceptionKind.unauthorized,
                httpErrorCode: httpErrorCode,
                serverError: serverError,
              );
            }

            return RemoteException(
              kind: RemoteExceptionKind.serverError,
              httpErrorCode: httpErrorCode,
              serverError: serverError,
            );
          }

          return RemoteException(
            kind: RemoteExceptionKind.serverDefined,
            httpErrorCode: httpErrorCode,
            rootException: exception,
          );
        case DioExceptionType.unknown:
          // Logger.logWarning("Not handled NoInternetException", name: "DioErrorMapper");
          if (exception is SocketException) {
            return RemoteException(
                kind: RemoteExceptionKind.network, rootException: exception);
          }
          if (exception is HttpException) {
            return RemoteException(
                kind: RemoteExceptionKind.noInternet, rootException: exception);
          }
          if (exception.error is RemoteException) {
            return exception.error as RemoteException;
          }
          return RemoteException(
              kind: RemoteExceptionKind.unknown, rootException: exception);
        default:
          return RemoteException(
              kind: RemoteExceptionKind.unknown, rootException: exception);
      }
    }

    return RemoteException(
        kind: RemoteExceptionKind.unknown, rootException: exception);
  }
}
