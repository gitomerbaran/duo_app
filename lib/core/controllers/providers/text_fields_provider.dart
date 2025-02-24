import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/textfields_state_model.dart';
import '../textfield_notifier.dart';

final textFieldProvider =
    StateNotifierProvider<TextFieldNotifier, TextFieldState>(
        (ref) => TextFieldNotifier());

final showPassword = AutoDisposeStateProvider<bool>((ref) {
  return false;
});
final showRePassword = AutoDisposeStateProvider<bool>((ref) {
  return false;
});
