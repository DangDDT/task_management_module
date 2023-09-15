import '../exceptions.dart';

class RemoteException extends AppException {
  const RemoteException({
    required this.kind,
    this.httpErrorCode,
    this.serverError,
    this.rootException,
  }) : super(AppExceptionType.remote);

  final RemoteExceptionKind kind;
  final int? httpErrorCode;
  final ServerError? serverError;
  final Object? rootException;

  int get generalServerStatusCode =>
      serverError?.generalServerStatusCode ??
      serverError?.errors.firstOrNull?.serverStatusCode ??
      0;
  String? get generalServerErrorId =>
      serverError?.generalServerErrorId ??
      serverError?.errors.firstOrNull?.serverErrorId;

  String? get generalServerMessage =>
      serverError?.generalMessage ?? serverError?.errors.firstOrNull?.message;

  String? get generalServerError => serverError?.generalError;

  @override
  String toString() {
    return '''RemoteException: {
      kind: $kind
      httpErrorCode: $httpErrorCode,
      serverError: $serverError,
      rootException: $rootException,
      generalServerMessage: $generalServerMessage,
      generalServerErrorCode: $generalServerStatusCode,
      generalServerErrorId: $generalServerErrorId,
      generalServerError: $generalServerError,
}''';
  }
}

enum RemoteExceptionKind {
  noInternet,

  /// host not found, cannot connect to host
  network,

  serverError,

  /// server has defined response with http status code 401
  unauthorized,

  /// server has defined response with http status code 403
  forbidden,

  /// server has defined response with http status code 500
  internalServerError,

  /// server has defined response with http status code 400
  badRequest,

  /// server has defined response with http status code 401
  unauthenticated,

  /// server has defined response
  serverDefined,

  /// server has not defined response
  serverUndefined,

  refreshTokenFailed,
  timeout,
  cancellation,
  unknown,
}

class NotFoundRemoteException extends RemoteException {
  NotFoundRemoteException({
    int? httpErrorCode,
    ServerError? serverError,
    Object? rootException,
  }) : super(
            kind: RemoteExceptionKind.serverDefined,
            serverError: serverError,
            rootException: rootException,
            httpErrorCode: httpErrorCode);
}

class UnprocessableEntityRemoteException extends RemoteException {
  UnprocessableEntityRemoteException({
    int? httpErrorCode,
    ServerError? serverError,
    Object? rootException,
  }) : super(
          kind: RemoteExceptionKind.serverDefined,
          serverError: serverError,
          rootException: rootException,
          httpErrorCode: httpErrorCode,
        );
}

class UnauthorizedRemoteException extends RemoteException {
  UnauthorizedRemoteException({
    int? httpErrorCode,
    ServerError? serverError,
    Object? rootException,
  }) : super(
          kind: RemoteExceptionKind.serverDefined,
          serverError: serverError,
          rootException: rootException,
          httpErrorCode: httpErrorCode,
        );
}
