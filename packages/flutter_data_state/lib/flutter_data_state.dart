library flutter_data_state;

import 'package:data_state/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';

typedef DataStateWidgetBuilder<T> = Widget Function(
    BuildContext context, DataState<T> state, Widget child);

class DataStateBuilder<T> extends StateNotifierBuilder<DataState<T>> {
  static ValueWidgetBuilder<DataState<T>> _convert<T>(
      DataStateWidgetBuilder<T> builder) {
    return (context, state, child) {
      return builder(context, state, child);
    };
  }

  DataStateBuilder({
    Key key,
    @required DataStateWidgetBuilder<T> builder,
    @required StateNotifier<DataState<T>> notifier,
    Widget child,
  })  : assert(builder != null),
        assert(notifier != null),
        super(
            key: key,
            builder: _convert(builder),
            stateNotifier: notifier,
            child: child);
}
