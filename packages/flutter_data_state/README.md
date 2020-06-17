# flutter_data_state

`DataStateBuilder` and other `data_state` Flutter utilities.

## 👩🏾‍💻 Usage

```dart
@override
Widget build(BuildContext context) {
  return DataStateBuilder<String>(
    notifier: notifierCallback,
    builder: (context, state, notifier, _) {
      return RefreshIndicator(
        onRefresh: notifier.reload,
        child: ListView(
          children: [
            if (state.isLoading) CircularProgressIndicator(),
            if (state.hasException) ExceptionWidget(state.exception.toString()),
            if (state.hasModel) ModelWidget(state.model),
          ],
        ),
      );
    },
  );
}
```

where `notifierCallback` is a `DataStateNotifier Function()` void callback.

Examples:

 - `() => repository.watchAll()`
 - `(() => future).asDataNotifier`
 - `(() => stream).asDataNotifier`

### Memoization

All notifiers are passed in `VoidCallback`s. They are memoized by default. If you don't want this, pass `memoize: false` (or control the behavior with `key`).

```dart
@override
Widget build(BuildContext context) {
  return DataStateBuilder<String>(
    notifier: notifierCallback
    memoize: false, // defaults to true
    key: Key(key), // optional
    builder: (context, state, notifier, _) {
      // ...
    },
  );
}
```

## ➕ Collaborating

Please use Github to ask questions, open issues and send PRs. Thanks!

## 📝 License

See [LICENSE](LICENSE)