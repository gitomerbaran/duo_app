import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseController<T> extends StateNotifier<T> {
  BaseController(super.state);

  void updateState(T newState) {
    state = newState;
  }

  void resetState(T initialState) {
    state = initialState;
  }
}
