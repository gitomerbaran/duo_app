import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/enums/text_field_enums.dart';
import 'models/textfields_state_model.dart';

class TextFieldNotifier extends StateNotifier<TextFieldState> {
  TextFieldNotifier() : super(const TextFieldState());

  /// TextField değerini güncelleme
  void updateText(TextFieldEnums key, String text) {
    state = state.copyWith(texts: {...state.texts, key: text});
  }

  /// Belirtilen textField değerini getir
  String getText(TextFieldEnums key) {
    return state.texts[key] ?? ''; // Eğer key yoksa boş string döndür
  }

  /// TextField boş mu kontrol et
  bool isTextFieldEmpty(TextFieldEnums key) {
    return (state.texts[key] ?? '').trim().isEmpty;
  }

  /// İki TextField değerinin aynı olup olmadığını kontrol et
  bool areFieldsEqual(TextFieldEnums key1, TextFieldEnums key2) {
    return state.texts[key1] == state.texts[key2];
  }

  /// Seçili textField'ı sıfırla
  void resetField(TextFieldEnums key) {
    final updatedTexts = Map<TextFieldEnums, String>.from(state.texts)..remove(key);
    final updatedValid = Map<TextFieldEnums, bool>.from(state.isValid)..remove(key);
    final updatedObscure = Map<TextFieldEnums, bool>.from(state.isObscure)..remove(key);
    
    state = TextFieldState(
        texts: updatedTexts, isValid: updatedValid, isObscure: updatedObscure);
  }

  /// Tüm TextField'ları sıfırla
  void resetAll() {
    state = state.reset();
  }
}
