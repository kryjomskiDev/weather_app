import 'dart:async';

mixin RefreshStreamMixin<T> {
  /// Not disposed because of his target is life in singleton
  // ignore: close_sinks
  final StreamController<T> _refreshStream = StreamController.broadcast();

  void notifyRefreshStream(T value) => _refreshStream.sink.add(value);

  Stream<T> getRefreshStream() => _refreshStream.stream;
}
