# DISCONTINUED

This package has been integrated (and improved) into [Flutter Data](https://github.com/flutterdata/flutter_data/)

---

# data_state

[![tests](https://img.shields.io/github/workflow/status/flutterdata/data_state/test/master?label=tests&labelColor=333940&logo=github)](https://github.com/flutterdata/data_state/actions) [![pub.dev](https://img.shields.io/pub/v/data_state?label=pub.dev&labelColor=333940&logo=dart)](https://pub.dev/packages/data_state) [![license](https://img.shields.io/github/license/flutterdata/data_state?color=%23007A88&labelColor=333940&logo=mit)](https://github.com/flutterdata/data_state/blob/master/LICENSE)

Easily produce and consume loading/error/data states in your application.

`DataState` is a [`StateNotifier`](https://pub.dev/packages/state_notifier)-based alternative to `AsyncSnapshot`.

 - Produce events from `DataStateNotifier`, `Future`, `Stream`, RxDart `ValueStream`
 - Consume events through `DataStateNotifier`, `Stream`

## 👩🏾‍💻 Usage

### Consuming state

Flutter example:

(Note: This example depends on [flutter_data_state](https://pub.dev/packages/flutter_data_state) which is a separate package)

```dart
@override
Widget build(BuildContext context) {
  return DataStateBuilder<List<Post>>(
    notifier: () => repo.watchPosts(),
    builder: (context, state, notifier, _) {
      return Column(
        children: [
          if (state.isLoading)
            CircularProgressIndicator(),
          if (state.hasException)
            ExceptionWidget(state.exception),
          if (state.hasModel)
            ShowPost(state.model),
        ],
      );
    }
  );
}
```

The notifier features a `reload` function, useful to restart a data loading cycle. It can be combined with a gesture detector or reloader widget:

Example 1:

```dart
GestureDetector(
  onTap: () => notifier.reload(), // will trigger a rebuild with isLoading = true
  child: _child,
)
```

Example 2:

```dart
RefreshIndicator(
  onRefresh: notifier.reload,
  child: _child,
),
```

### Future & Stream input support

This package exposes an extension on `Future<T> Function()` called `asDataNotifier`.

It allows to turn any future into a `DataStateNotifier` callback to leverage caching and reloading capabilities.

Example 1:

```dart
final notifier = (() => future).asDataNotifier;
```

Example 2:

```dart
final notifier = (() {
  if (Random().nextInt(10) > 4) {
    return Future<String>.error('Error!');
  }
  return Future.delayed(
    Duration(seconds: 1),
    () => 'HELLO RANDOM: ${Random().nextInt(100)}!',
  );
}).asDataNotifier;
```

Same for `Stream`s and `ValueStream`s:

```dart
final notifier = (() => stream).asDataNotifier;
```

### Consuming streams

Want to consume events via streams?

`DataStateNotifier` actually exposes an RxDart `ValueStream`:

```dart
@override
Widget build(BuildContext context) {
  final stream = repo.watchPosts().stream;
  return StreamBuilder<List<Post>>(
    initial: stream.value,
    stream: stream,
    builder: (context, snapshot) {
      // snapshot as usual
    }
  );
}
```

This is the anatomy of an immutable `DataState` object:

```dart
final state = DataState({
  T model,
  bool isLoading = false,
  Object exception,
  StackTrace stackTrace,
});
```

### 🎸 Producing state

Example:

```dart
DataStateNotifier<List<Post>> watchPosts() {
  final notifier = DataStateNotifier<List<Post>>(
    DataState(model: getLocalPosts()),
    reload: (notifier) async {
      notifier.state = notifier.state.copyWith(isLoading: true);
      try {
        notifier.data = await loadPosts();
      } catch (error, stackTrace) {
        notifier.data = notifier.data.copyWith(exception: error, stackTrace: stackTrace);
      }
    },
  );

  // kick off cycle
  return notifier..reload();
}
```

The `DataStateNotifier` constructor takes:

 - `state` as the first positional argument
 - `reload` and `onError` as optional named arguments

## ⁉ FAQ

### Why is `DataState` not a freezed union?

This would allow us to do the following destructuring:

```dart
state.when(
  data: (data) => Text(data),
  loading: () => const CircularProgressIndicator(),
  error: (error, stackTrace) => Text('Error $error'),
);
```

This turns out to be impractical in data-driven Flutter apps as there are cases where we need to render loading/error messages _in addition to_ data – not _instead of_ data.

### Does DataStateNotifier depend on Flutter?

No. It can used with pure Dart.

## ➕ Collaborating

Please use Github to ask questions, open issues and send PRs. Thanks!

## 📝 License

See [LICENSE](LICENSE)
