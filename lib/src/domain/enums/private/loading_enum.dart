enum LoadingState {
  initial,
  loading,
  success,
  error,
  empty;

  bool get isLoading => this == LoadingState.loading;

  bool get isSuccess => this == LoadingState.success;

  bool get isError => this == LoadingState.error;

  bool get isEmpty => this == LoadingState.empty;

  bool get isInitial => this == LoadingState.initial;
}
