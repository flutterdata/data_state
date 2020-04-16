## [0.2.3] - 2020-04-15

 * Change dependency to be compatible with flutter_test

## [0.2.2] - 2020-04-15

 * Add tests
 * Improve documentation

## [0.2.1] - 2020-04-03

 * Make `stream` emit a `ValueStream<T>` (not a `ValueStream<DataState<T>>`) so it plays better with AsyncSnapshot (useful for incremental upgrades)

## [0.2.0] - 2020-03-23

 * Make `model` an optional argument
 * Improve docs

## [0.1.1] - 2020-03-12

 * Make initial state optional

## [0.1.0] - 2020-03-12

 * Add `DataState` immutable class carries data, loading and exception information
 * Add `DataStateNotifier` class, a `StateNotifier` for `DataState` objects that additionally supports a  Stream API
 * Write README