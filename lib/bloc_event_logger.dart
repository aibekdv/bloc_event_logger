import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocEventLogger extends BlocObserver {
  final Set<Type>? includeBlocs;
  final bool logEvents;
  final bool logChanges;
  final bool logErrors;
  final bool logTransitions;
  final bool logClose;

  const BlocEventLogger({
    this.includeBlocs,
    this.logEvents = true,
    this.logChanges = true,
    this.logErrors = true,
    this.logTransitions = false,
    this.logClose = true,
  });

  bool _shouldLog(BlocBase bloc, bool logFlag) {
    if (!logFlag) return false;
    if (includeBlocs != null && !includeBlocs!.contains(bloc.runtimeType)) {
      return false;
    }
    return true;
  }

  void _log(String title, String name, String content) {
    final border = '═════════════════════════════════════════════════';

    developer.log('''
$name
$border
$content
$border
''', name: "BLOC $title");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (!_shouldLog(bloc, logEvents)) return;
    _log('EVENT', bloc.runtimeType.toString(), 'Event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (!_shouldLog(bloc, logChanges)) return;
    _log(
      'STATE',
      bloc.runtimeType.toString(),
      'Current: ${change.currentState}\nNext:    ${change.nextState}',
    );
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (!_shouldLog(bloc, logErrors)) return;
    _log(
      'ERROR',
      bloc.runtimeType.toString(),
      'Error: $error\n\nStackTrace:\n$stackTrace',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (!_shouldLog(bloc, logTransitions)) return;
    _log(
      'TRANSITION',
      bloc.runtimeType.toString(),
      'Event: ${transition.event}\nCurrent: ${transition.currentState}\nNext: ${transition.nextState}',
    );
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    if (!_shouldLog(bloc, logClose)) return;
    _log('CLOSE', bloc.runtimeType.toString(), 'Bloc closed.');
    super.onClose(bloc);
  }
}
