import '../../../domain.dart';
import '../base/base_error_response_mapper.dart';

class JsonObjectErrorResponseMapper
    extends BaseErrorResponseMapper<Map<String, dynamic>?> {
  @override
  ServerError mapFromResponse(Map<String, dynamic>? response) {
    return ServerError(
      generalServerStatusCode: response?['statusCode'],
      generalMessage: response?['message'],
      generalError: response?['error'],
    );
  }
}
