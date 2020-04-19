# data_state

[![tests](https://img.shields.io/github/workflow/status/flutterdata/data_state/test/master?label=tests&labelColor=333940&logo=github)](https://github.com/flutterdata/data_state/actions) [![pub.dev](https://img.shields.io/pub/v/data_state?label=pub.dev&labelColor=333940&logo=dart)](https://pub.dev/packages/data_state) [![license](https://img.shields.io/github/license/flutterdata/data_state?color=%23007A88&labelColor=333940&logo=mit)](https://github.com/flutterdata/data_state/blob/master/LICENSE)

Easily produce and consume loading/error/data states in your application.

`DataState` is a [`StateNotifier`](https://pub.dev/packages/state_notifier)-based alternative to `AsyncSnapshot`.

 - Produce events: notifier API
 - Consume events: notifier API & stream API

## 👩🏾‍💻 Usage

### Consuming state

Flutter example:

```dart
@override
Widget build(BuildContext context) {
  return StateNotifierBuilder<DataState<List<Post>>>(
    stateNotifier: repo.watchPosts(),
    builder: (context, state, _) {
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

The notifier also supports a `reload` function to restart a data loading cycle. It can be combined with a gesture detector or reloader widget:

Example 1:

```dart
GestureDetector(
  onTap: () => notifier.reload(), // will trigger a rebuild with isLoading = true
  child: _child,
)
```

Example 2:

```dart
body: EasyRefresh.builder(
  controller: _refreshController,
  onRefresh: () async {
    await notifier.reload();
    _refreshController.finishRefresh();
  },
```

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
      notifier.state = DataState(model: await loadPosts());
    },
    onError: (notifier, error, stackTrace) {
      notifier.state = notifier.state
          .copyWith(exception: error, stackTrace: stackTrace);
    },
  );

  // start cycle
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

MIT