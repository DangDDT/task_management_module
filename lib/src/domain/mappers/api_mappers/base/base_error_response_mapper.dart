import '../../../domain.dart';
import '../error_response_mapper/json_object_error_response_mapper.dart';

abstract class BaseErrorResponseMapper<T> {
  const BaseErrorResponseMapper();

  ServerError mapFromResponse(T response);

  factory BaseErrorResponseMapper.fromType(ErrorResponseMapperType type) {
    switch (type) {
      case ErrorResponseMapperType.jsonObject:
        return JsonObjectErrorResponseMapper() as BaseErrorResponseMapper<T>;
    }
  }
}

enum ErrorResponseMapperType {
  jsonObject,
}
