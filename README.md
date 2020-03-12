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
final notifier = DataStateNotifier<List<T>>();

// supply a reload function
final reload = () async {
  notifier.state = notifier.state.copyWith(isLoading: true);
  try {
    final model = await _loadAll(params);
    notifier.state = notifier.state.copyWith(model: model, isLoading: false);
  } catch (e) {
    notifier.state = notifier.state.copyWith(exception: DataException(e));
  }
};

notifier.state = DataState(cachedModels, reload: reload),

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

## FAQ

#### Why is `DataState` not a freezed union?

This would allow us to do the following destructuring:

```dart
state.when(
  data: (data) => Text(data),
  loading: () => const CircularProgressIndicator(),
  error: (error, stackTrace) => Text('Error $error'),
);
```

This turns out to be impractical in Flutter widgets, as there are cases where we need to render loading/error messages _in addition to_ data, and not _instead of_ data.

## ➕ Collaborating

Please use Github to ask questions, open issues and send PRs. Thanks!

## 📝 License

MIT