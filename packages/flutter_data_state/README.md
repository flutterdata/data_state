# flutter_data_state

DataStateBuilder and other `data_state` Flutter utilities.

## 👩🏾‍💻 Usage

```dart
@override
Widget build(BuildContext context) {
  return DataStateBuilder<List<Post>>(
    notifier: repo.watchPosts(),
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

## ➕ Collaborating

Please use Github to ask questions, open issues and send PRs. Thanks!

## 📝 License

See [LICENSE](LICENSE)