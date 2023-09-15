import '../../../../../core/core.dart';
import '../../../models/models.dart';
import '../base/base_success_response_mapper.dart';

class DataJsonObjectResponseMapper<T>
    extends BaseSuccessResponseMapper<T, DataResponse<T>> {
  @override
  DataResponse<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic>
        ? DataResponse.fromJson(response, (json) => decoder(json))
        : DataResponse<T>(data: response);
  }
}
