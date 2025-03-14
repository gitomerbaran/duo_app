import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/enums/text_field_enums.dart';
import '../models/textfields_state_model.dart';

class TextFieldNotifier extends StateNotifier<TextFieldState> {
  TextFieldNotifier() : super(const TextFieldState()) {
    _initControllers();
  }

  final Map<TextFieldEnums, TextEditingController> _controllers = {};

  /// TextField controller'larını başlat
  void _initControllers() {
    for (var key in TextFieldEnums.values) {
      _controllers[key] = TextEditingController();
    }
  }

  /// Belirli bir TextFieldEnums için controller döndür
  TextEditingController getController(TextFieldEnums key) {
    return _controllers[key]!;
  }

  /// TextField değerini güncelleme (ve controller'ı güncelleme)
  void updateText(TextFieldEnums key, String text) {
    state = state.copyWith(texts: {...state.texts, key: text});
    _controllers[key]?.text = text; // Controller'ı güncelle
  }

  /// Tüm TextField'ları sıfırla
  void resetAll() {
    debugPrint("Tüm TextField'lar sıfırlanıyor...");
    for (var controller in _controllers.values) {
      controller.clear();
    }
    state = TextFieldState();
  }

  /// Notifier dispose edilince controller'ları da temizle
  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
