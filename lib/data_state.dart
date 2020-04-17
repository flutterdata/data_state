library data_state;

import 'package:rxdart/rxdart.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
abstract class DataState<T> with _$DataState<T> {
  factory DataState({
    T model,
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
  DataStateNotifier(DataState<T> state, {
      Future<void> Function(DataStateNotifier<T>) reload,
      void Function(DataStateNotifier<T>, dynamic, StackTrace) onError,
    })
    : _reloadFn = reload,
      super(state ?? DataState<T>()) {
        super.onError = (error, stackTrace) {
          return onError?.call(this, error, stackTrace);
        };
      }

  final Future<void> Function(DataStateNotifier<T>) _reloadFn;

  @override
  get state => super.state;

  @override
  set state(DataState<T> value) {
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

  @override
  void dispose() {
    _subject?.close();
    super.dispose();
  }

  // stream API

  ValueStream<T> _stream;
  BehaviorSubject<T> _subject;

  ValueStream<T> _initStream() {
    _subject = BehaviorSubject<T>.seeded(state.model);
    return _subject.stream;
  }

  ValueStream<T> get stream => _stream ??= _initStream();

}