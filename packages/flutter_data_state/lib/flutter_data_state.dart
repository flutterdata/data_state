library flutter_data_state;

import 'package:data_state/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

typedef DataStateWidgetBuilder<T> = Widget Function(BuildContext context,
    DataState<T> state, DataStateNotifier<T> notifier, Widget child);

class DataStateBuilder<T> extends StatefulWidget {
  final DataStateNotifier<T> Function() notifier;
  final DataStateWidgetBuilder<T> builder;
  final bool memoize;

  const DataStateBuilder({
    Key key,
    @required this.notifier,
    @required this.builder,
    this.memoize = true,
  }) : super(key: key);

  @override
  _DataStateBuilderState<T> createState() => _DataStateBuilderState<T>();
}

class _DataStateBuilderState<T> extends State<DataStateBuilder<T>> {
  DataStateNotifier<T> _memoizedNotifier;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<DataState<T>>(
      stateNotifier: _memoizedNotifier ??= widget.notifier.call(),
      builder: (context, state, child) {
        return widget.builder(context, state, _memoizedNotifier, child);
      },
    );
  }
}
