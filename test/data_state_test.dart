import 'package:data_state/data_state.dart';
import 'package:test/test.dart';
import 'package:async/async.dart';

void main() {

  test('DataState', () {
    final state = DataState();
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

    final state4 = state3.copyWith(exception: null, model: "data");
    expect(state4.hasModel, true);
    expect(state4.model, "data");
    expect(state4.exception, isNull);
    expect(state4.hasException, false);
  });

  group('notifier', () {
    DataStateNotifier notifier;
    final delay = () => Future.delayed(Duration(milliseconds: 12));
    
    setUpAll(() {
      notifier = DataStateNotifier(
        DataState(model: 'initial'),
        onError: (notifier, e, _) {
          expect(e, predicate((e) => e.message == 'zzz'));
        }
      );
    });

    test('defaults', () {
      expect(notifier.reload, isNotNull);
      expect(notifier.onError, isNotNull);
    });

    test('updates state', () async {
      int i = 0;
      final dispose = notifier.addListener((state) {
        switch (i) {
          case 0:
            expect(state.model, "initial");
            break;
          case 1:
            expect(state.model, "data");
            break;
          case 2:
            expect(state.model, "data2");
            break;
          case 3:
            expect(state.model, "data3");
            break;
          default:
            throw Exception('zzz');
        }
      }, fireImmediately: false);

      i++;
      notifier.state = DataState(model: "data");
      i++;
      notifier.state = DataState(model: "data2");
      i++;
      notifier.state = DataState(model: "data3");
      i++;
      notifier.state = DataState(model: "data4");
      // await delay();
      // i++;
      dispose();
    });

    test('watchAll', () async {
      notifier.state = DataState(model: 'initial');
      (() async {
        await delay();
        notifier.state = notifier.state.copyWith(model: 'data4');
        await delay();
        notifier.state = notifier.state.copyWith(model: 'data5');
        await delay();
        notifier.state = DataState(exception: Exception('error'));
      })();

      final stream = StreamQueue(notifier.stream);

      await expectLater(
        stream,
        emitsInOrder([
          predicate((state) => state == 'initial'),
          predicate((state) => state == 'data4'),
          predicate((state) => state == 'data5'),
          emitsError(isA<Exception>()),
        ]),
      );

      
    });

    tearDownAll(() {
      notifier.dispose();
    });    
  });

}
