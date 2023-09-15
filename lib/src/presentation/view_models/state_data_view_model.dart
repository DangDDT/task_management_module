// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../../domain/domain.dart';

class StateDataVM<T> {
  StateDataVM(this.data, this.errorMessage,
      {this.state = LoadingState.initial});

  final LoadingState state;
  T? data;
  String? errorMessage;

  static none<E>(Type type) {
    switch (type) {
      case List:
        final List<E> list = [];
        return StateDataVM(list, null);
      case RxList:
        final RxList<E> list = RxList<E>.empty();
        return StateDataVM(list, null);
      default:
        return StateDataVM<E>(null, null);
    }
  }

  StateDataVM<T> _copyWith({
    LoadingState? state,
    T? data,
    required String? errorMessage,
  }) {
    return StateDataVM<T>(
      data ?? this.data,
      errorMessage,
      state: state ?? this.state,
    );
  }

  StateDataVM<T> setLoading() {
    return _copyWith(errorMessage: null, state: LoadingState.loading);
  }

  StateDataVM<T> setSuccess(T data) {
    return _copyWith(
        data: data, errorMessage: null, state: LoadingState.success);
  }

  StateDataVM<T> setError(String errorMessage) {
    return _copyWith(errorMessage: errorMessage, state: LoadingState.error);
  }

  StateDataVM<T> setEmpty() {
    return _copyWith(errorMessage: null, state: LoadingState.empty);
  }

  bool get isInitial => state == LoadingState.initial;

  bool get isLoading => state == LoadingState.loading;

  bool get isSuccess => state == LoadingState.success;

  bool get isError => state == LoadingState.error;

  bool get isEmpty => state == LoadingState.empty;

  bool get hasError => errorMessage != null;

  @override
  bool operator ==(covariant StateDataVM<T> other) {
    if (identical(this, other)) return true;

    return other.state == state;
  }

  @override
  int get hashCode => state.hashCode;
}
