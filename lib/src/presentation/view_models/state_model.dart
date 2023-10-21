import 'package:get/get.dart';

import '../../domain/domain.dart';

class StateModel<T> {
  final Rx<T> data;
  final Rxn<String> errorMessage;
  final Rx<LoadingState> state;

  StateModel({required this.data})
      : errorMessage = Rxn(),
        state = Rx<LoadingState>(LoadingState.initial);

  bool get isLoading => state.value.isLoading;

  bool get isSuccess => state.value.isSuccess;

  bool get isError => state.value.isError;

  bool get isEmpty => state.value.isEmpty;

  bool get isInitial => state.value.isInitial;

  void initial({required T initialData}) {
    data.value = initialData;
    state.value = LoadingState.initial;
  }

  void loading({T? loadingData}) {
    if (loadingData != null) data.value = loadingData;
    state.value = LoadingState.loading;
  }

  void success(T data) {
    this.data.value = data;
    state.value = LoadingState.success;
  }

  void error(String message, {T? errorData}) {
    if (errorData != null) this.data.value = errorData;
    errorMessage.value = message;
    state.value = LoadingState.error;
  }

  void empty({T? emptyData}) {
    if (emptyData != null) this.data.value = emptyData;
    state.value = LoadingState.empty;
  }
}
