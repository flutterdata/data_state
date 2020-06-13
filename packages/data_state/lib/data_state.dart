library data_state;

import 'package:rxdart/rxdart.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
abstract class DataState<T> with _$DataState<T> {
  factory DataState(
    @nullable T model, {
    @Default(false) bool isLoading,
    Object exception,
    StackTrace stackTrace,
  }) = _DataState<T>;

  @late
  bool get hasException => exception != null;

  @late
  bool get hasModel => model != null;
}

class DataStateNotifier<T> extends StateNotifier<DataState<T>> {
  DataStateNotifier(
    DataState<T> state, {
    Future<void> Function(DataStateNotifier<T>) reload,
    void Function(DataStateNotifier<T>, dynamic, StackTrace) onError,
  })  : _reloadFn = reload,
        super(state ?? DataState<T>(null));

  final Future<void> Function(DataStateNotifier<T>) _reloadFn;

  DataState<T> get data => super.state;

  set data(DataState<T> value) {
    try {
      super.state = value;
    } catch (err) {
      // silence the unnecessary error thrown by StateNotifier
    }
    if (_subject != null) {
      if (state.hasException) {
        _subject.addError(state.exception, state.stackTrace);
        return;
      }
      _subject.add(state.model);
    }
  }

  Future<void> reload() {
    return _reloadFn?.call(this) ?? ((_) async {});
  }

  // stream API

  ValueStream<T> get stream => _stream ??= _initStream();

  ValueStream<T> _stream;
  BehaviorSubject<T> _subject;

  ValueStream<T> _initStream() {
    _subject = BehaviorSubject<T>.seeded(state.model, onCancel: () {
      // close the underlying notifier when closing this stream
      dispose();
    });
    return _subject.stream;
  }
}
