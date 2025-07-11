import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestEvent {}

class TestState {
  final int value;
  TestState(this.value);
}

class DummyBloc extends Bloc<TestEvent, TestState> {
  DummyBloc() : super(TestState(0)) {
    on<TestEvent>((event, emit) {
      emit(TestState(state.value + 1));
    });
  }
}

class TestObserver extends BlocObserver {
  bool eventCalled = false;
  bool changeCalled = false;

  @override
  void onEvent(Bloc bloc, Object? event) {
    eventCalled = true;
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    changeCalled = true;
    super.onChange(bloc, change);
  }
}

void main() {
  test('BlocObserver onEvent and onChange are called', () async {
    final observer = TestObserver();
    Bloc.observer = observer;

    final bloc = DummyBloc();

    bloc.add(TestEvent());

    await Future.delayed(const Duration(milliseconds: 100));

    expect(observer.eventCalled, isTrue);
    expect(observer.changeCalled, isTrue);

    await bloc.close();
  });
}
