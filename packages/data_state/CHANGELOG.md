## [0.3.7] - 2020-10-07

- revert 0.3.6 issue

## [0.3.6] - 2020-10-07

- upgrade deps

## [0.3.5] - 2020-09-16

- upgrade deps

## [0.3.4] - 2020-07-26

- simplify API

## [0.3.3] - 2020-06-22

- upgrade `freezed`

## [0.3.2] - 2020-06-17

- support producing events from `Future` and `Stream`

## [0.3.0] - 2020-06-13

- `model` is now a positional argument
- Update `state_notifier` and `rxdart`

## [0.2.7] - 2020-04-19

- Stupid formatting fix

## [0.2.6] - 2020-04-19

- Fix docs/license

## [0.2.5] - 2020-04-18

- Rearrange project layout, add `DataStateBuilder`
- Stream should dispose of notifier, not the other way round

## [0.2.4] - 2020-04-16

- Add `onError`
- Move `reload` to notifier and supply it as param
- More tests and improved docs

## [0.2.3] - 2020-04-15

- Change dependency to be compatible with flutter_test

## [0.2.2] - 2020-04-15

- Add tests
- Improve documentation

## [0.2.1] - 2020-04-03

- Make `stream` emit a `ValueStream<T>` (not a `ValueStream<DataState<T>>`) so it plays better with AsyncSnapshot (useful for incremental upgrades)

## [0.2.0] - 2020-03-23

- Make `model` an optional argument
- Improve docs

## [0.1.1] - 2020-03-12

- Make initial state optional

## [0.1.0] - 2020-03-12

- Add `DataState` immutable class carries data, loading and exception information
- Add `DataStateNotifier` class, a `StateNotifier` for `DataState` objects that additionally supports a Stream API
- Write README
