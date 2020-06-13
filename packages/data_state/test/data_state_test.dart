import 'package:data_state/data_state.dart';
import 'package:test/test.dart';

void main() {
  test('DataState', () {
    final state = DataState<String>(null);
    expect(state.exception, isNull);
    expect(state.hasException, false);
    expect(state.isLoading, false);
    expect(state.model, isNull);
    expect(state.hasModel, false);

    final state2 = state.copyWith(exception: Exception());
    expect(state2.exception, isNotNull);
    expect(state2.hasException, true);

    final state3 = state2.copyWith(isLoading: true);
    expect(state3.exception, isNotNull);
    expect(state3.hasException, true);
    expect(state3.isLoading, true);

    final state4 = state3.copyWith(model: 'data', exception: null);
    expect(state4.hasModel, true);
    expect(state4.model, 'data');
    expect(state4.exception, isNull);
    expect(state4.hasException, false);
  });

  group('notifier', () {
    DataStateNotifier notifier;
    final delay = () => Future.delayed(Duration(milliseconds: 12));

    setUpAll(() {
      notifier = DataStateNotifier(
        DataState('initial'),
        onError: (notifier, e, _) {
          expect(e, predicate((e) => e.message == 'zzz'));
        },
      );
    });

    test('updates state', () async {
      int i = 0;
      final dispose = notifier.addListener((state) {
        switch (i) {
          case 0:
            expect(state.model, 'initial');
            break;
          case 1:
            expect(state.model, 'data');
            break;
          case 2:
            expect(state.model, 'data2');
            break;
          case 3:
            expect(state.model, 'data3');
            break;
          case 4:
            expect(state.model, 'data4');
            break;
          default:
            throw Exception('zzz');
        }
      }, fireImmediately: false);

      i++;
      notifier.data = DataState('data');
      i++;
      notifier.data = DataState('data2');
      i++;
      notifier.data = DataState('data3');
      await delay();
      i++;
      notifier.data = DataState('data4');
      dispose();
    });

    tearDownAll(() {
      notifier.dispose();
    });
  });
}
