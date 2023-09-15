import 'dart:async';

mixin DebounceMixin {
  Timer? _debounce;

  onDoSomethingWithDebounce(String query);

  void onDebounce(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 810), () {
      onDoSomethingWithDebounce(query);
    });
  }

  void disposeDebounce() {
    _debounce?.cancel();
  }
}
