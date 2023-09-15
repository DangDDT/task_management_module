import '../../../../../core/core.dart';
import '../../../models/models.dart';
import '../base/base_success_response_mapper.dart';

class ResultJsonArrayResponseMapper<T>
    extends BaseSuccessResponseMapper<T, ResultListResponse<T>> {
  @override
  // ignore: avoid-dynamic
  ResultListResponse<T> map(dynamic response, Decoder<T>? decoder) {
    return decoder != null && response is Map<String, dynamic>
        ? ResultListResponse.fromJson(response, (json) => decoder(json))
        : ResultListResponse<T>(result: response);
  }
}
