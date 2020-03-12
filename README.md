# data_state

A practical alternative to AsyncSnapshot, with both notifier and stream APIs.

## 👩🏾‍💻 Usage

Creating states:

```dart
final T model;
final state = DataState<T>(model, isLoading: true);
emit(state);

// ...

final state2 = state.copyWith(isLoading: false);
emit(state2);

// ...

final state3 = state.copyWith(exception: DataException(code: 21));
emit(state3);
```

Now with a state notifier:

```dart
final notifier = DataStateNotifier<List<T>>(
  DataState(allModels, isLoading: true),
);

// ...

// supply a reload function
notifier.state = notifier.state.copyWith(model: updatedAllModels, isLoading: false, reload: () async {
  notifier.state = notifier.state.copyWith(isLoading: true);
  final model = await repo.findAll(params);
  notifier.state = notifier.state.copyWith(model: model, isLoading: false);
});

// ...

notifier.state = notifier.state.copyWith(exception: DataException(code: 21));
```

Consuming states via `StateNotifier`:

```dart
StateNotifierBuilder<DataState<List<Post>>>(
  stateNotifier: repo.watchPosts(),
  builder: (context, state, _) {
    final posts = state.model;
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // ...

    if (state.hasException) {
      return ShowError(state.exception, state.stackTrace);
    }

    // ...

    GestureDetector(
      onTap: () => state.reload(), // will trigger a rebuild with isLoading = true
      child: _child,
    )
  }
)
```

Consuming states via RxDart's `ValueStream`:

```dart
StreamBuilder<DataState<List<Post>>>(
  stream: repo.watchPosts().stream,
  builder: (context, snapshot) {
    // can immediately and safely access snapshot.data
    final state = snapshot.data;
    // ...
  }
)
```

## ➕ Collaborating

Please use Github to ask questions, open issues and send PRs. Thanks!

## 📝 License

MIT