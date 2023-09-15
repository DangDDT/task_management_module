import '../../../../../core/core.dart';
import '../../../domain.dart';
import '../base/base_success_response_mapper.dart';

class DataJsonArrayResponseMapper<T>
    extends BaseSuccessResponseMapper<T, DataListResponse<T>> {
  @override
  DataListResponse<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic>
        ? DataListResponse.fromJson(response, (json) => decoder(json))
        : DataListResponse<T>(data: response);
  }
}
