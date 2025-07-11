# bloc_event_logger

A simple and customizable BlocObserver for flutter_bloc to log Bloc events, state changes, errors, and transitions with clean and readable output.  
Helps developers debug and monitor their Bloc state management effectively.

## Features

- Logs all Bloc events added
- Logs state changes (`onChange`)
- Logs errors (`onError`)
- Logs transitions (`onTransition`)
- Easy to integrate and customize

## Installation

Add this to your package's `pubspec.yaml`:

```yaml
dependencies:
  bloc_event_logger: ^0.1.0
````

Then run:

```bash
flutter pub get
```

## Usage

Set the `Bloc.observer` to an instance of `BlocEventLogger` early in your app, for example in `main.dart`:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_event_logger/bloc_event_logger.dart';

void main() {
  Bloc.observer = const BlocEventLogger();
  runApp(MyApp());
}
```

Now, all Bloc events, state changes, errors, and transitions will be logged automatically.

## Example

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
  }
}

void main() {
  Bloc.observer = const BlocEventLogger();
  final bloc = CounterBloc();

  bloc.add(Increment());
}
```

