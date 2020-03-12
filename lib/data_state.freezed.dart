// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of data_state;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

mixin _$DataState<T> {
  T get model;
  bool get isLoading;
  Object get exception;
  StackTrace get stackTrace;
  Future<void> Function() get reload;

  DataState<T> copyWith(
      {T model,
      bool isLoading,
      Object exception,
      StackTrace stackTrace,
      Future<void> Function() reload});
}

class _$DataStateTearOff {
  const _$DataStateTearOff();

  _DataState<T> call<T>(T model,
      {bool isLoading = false,
      Object exception,
      StackTrace stackTrace,
      Future<void> Function() reload}) {
    return _DataState<T>(
      model,
      isLoading: isLoading,
      exception: exception,
      stackTrace: stackTrace,
      reload: reload,
    );
  }
}

const $DataState = _$DataStateTearOff();

class _$_DataState<T> implements _DataState<T> {
  _$_DataState(this.model,
      {this.isLoading = false, this.exception, this.stackTrace, this.reload})
      : assert(model != null);

  @override
  final T model;
  @JsonKey(defaultValue: false)
  @override
  final bool isLoading;
  @override
  final Object exception;
  @override
  final StackTrace stackTrace;
  @override
  final Future<void> Function() reload;
  bool _didhasException = false;
  bool _hasException;

  @override
  bool get hasException {
    if (_didhasException == false) {
      _didhasException = true;
      _hasException = exception != null;
    }
    return _hasException;
  }

  bool _didhasModel = false;
  bool _hasModel;

  @override
  bool get hasModel {
    if (_didhasModel == false) {
      _didhasModel = true;
      _hasModel = model != null;
    }
    return _hasModel;
  }

  @override
  String toString() {
    return 'DataState<$T>(model: $model, isLoading: $isLoading, exception: $exception, stackTrace: $stackTrace, reload: $reload, hasException: $hasException, hasModel: $hasModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DataState<T> &&
            (identical(other.model, model) ||
                const DeepCollectionEquality().equals(other.model, model)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.exception, exception) ||
                const DeepCollectionEquality()
                    .equals(other.exception, exception)) &&
            (identical(other.stackTrace, stackTrace) ||
                const DeepCollectionEquality()
                    .equals(other.stackTrace, stackTrace)) &&
            (identical(other.reload, reload) ||
                const DeepCollectionEquality().equals(other.reload, reload)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(model) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(exception) ^
      const DeepCollectionEquality().hash(stackTrace) ^
      const DeepCollectionEquality().hash(reload);

  @override
  _$_DataState<T> copyWith({
    Object model = freezed,
    Object isLoading = freezed,
    Object exception = freezed,
    Object stackTrace = freezed,
    Object reload = freezed,
  }) {
    return _$_DataState<T>(
      model == freezed ? this.model : model as T,
      isLoading: isLoading == freezed ? this.isLoading : isLoading as bool,
      exception: exception == freezed ? this.exception : exception,
      stackTrace:
          stackTrace == freezed ? this.stackTrace : stackTrace as StackTrace,
      reload:
          reload == freezed ? this.reload : reload as Future<void> Function(),
    );
  }
}

abstract class _DataState<T> implements DataState<T> {
  factory _DataState(T model,
      {bool isLoading,
      Object exception,
      StackTrace stackTrace,
      Future<void> Function() reload}) = _$_DataState<T>;

  @override
  T get model;
  @override
  bool get isLoading;
  @override
  Object get exception;
  @override
  StackTrace get stackTrace;
  @override
  Future<void> Function() get reload;

  @override
  _DataState<T> copyWith(
      {T model,
      bool isLoading,
      Object exception,
      StackTrace stackTrace,
      Future<void> Function() reload});
}
