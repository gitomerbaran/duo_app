import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseNotifier<T> extends StateNotifier<T> {
  BaseNotifier(super.state);

  void updateState(T newState) {
    state = newState;
  }

  void resetState(T initialState) {
    state = initialState;
  }
}
