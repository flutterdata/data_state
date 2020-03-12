library data_state;

import 'package:rxdart/rxdart.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

/// A practical alternative to the AsyncSnapshot API
@freezed
abstract class DataState<T> with _$DataState<T> {
  factory DataState(T model, {
    @Default(false) bool isLoading,
    Object exception,
    StackTrace stackTrace,
    Future<void> Function() reload,
  }) = _DataState<T>;

  @late
  bool get hasException => exception != null;

  @late
  bool get hasModel => model != null;
}

class DataStateNotifier<T> extends StateNotifier<DataState<T>> {
  DataStateNotifier(DataState<T> state) : super(state);

  ValueStream<DataState<T>> _stream;
  BehaviorSubject<DataState<T>> _subject;

  ValueStream<DataState<T>> _initStream() {
    _subject = BehaviorSubject<DataState<T>>.seeded(state);
    return _subject.stream;
  }

  @override
  get state => super.state;

  @override
  set state(DataState<T> value) {
    super.state = value;
    if (_subject != null) {
      if (state.hasException) {
        _subject.addError(state.exception, state.stackTrace);
        return;
      }
      _subject.add(state);
    }
  }

  ValueStream<DataState<T>> get stream => _stream ??= _initStream();

  @override
  void dispose() {
    _subject?.close();
    super.dispose();
  }
}