library flutter_data_state;

import 'package:data_state/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

typedef DataStateWidgetBuilder<T> = Widget Function(BuildContext context,
    DataState<T> state, DataStateNotifier<T> notifier, Widget child);

// TODO
// besides notifier/lazyNotifier, also take
// future/lazyFuture; stream/lazyStream
// so as to provide memoization/reload capabilities to those
// const DataStateBuilder({
//   Key key,
//   dynamic source,
//   @required this.builder,
// })
// assert(source is DataStateNotifier<T> Function() || source is DataStateNotifier<T> || Future<T> || Stream<T>)

class DataStateBuilder<T> extends StatefulWidget {
  final DataStateNotifier<T> notifier;
  final DataStateNotifier<T> Function() lazyNotifier;
  final DataStateWidgetBuilder<T> builder;

  const DataStateBuilder({
    Key key,
    this.notifier,
    this.lazyNotifier,
    @required this.builder,
  })  : assert(
            (notifier == null || lazyNotifier == null) &&
                (notifier != null || lazyNotifier != null),
            'You must provide ONE of: `notifier`, `lazyNotifier` as parameters.'),
        super(key: key);

  @override
  _DataStateBuilderState<T> createState() => _DataStateBuilderState<T>();
}

class _DataStateBuilderState<T> extends State<DataStateBuilder<T>> {
  DataStateNotifier<T> _cachedNotifier;

  @override
  void initState() {
    super.initState();
    _cachedNotifier = widget.lazyNotifier?.call() ?? widget.notifier;
  }

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<DataState<T>>(
      stateNotifier: _cachedNotifier,
      builder: (context, state, child) {
        return widget.builder(context, state, _cachedNotifier, child);
      },
    );
  }
}
