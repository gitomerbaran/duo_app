import 'package:equatable/equatable.dart';
import '../../constants/enums/text_field_enums.dart';

class TextFieldState extends Equatable {
  final Map<TextFieldEnums, String> texts;
  final Map<TextFieldEnums, bool> isValid;
  final Map<TextFieldEnums, bool> isObscure;

  const TextFieldState({
    this.texts = const {},
    this.isValid = const {},
    this.isObscure = const {},
  });

  TextFieldState copyWith({
    Map<TextFieldEnums, String>? texts,
    Map<TextFieldEnums, bool>? isValid,
    Map<TextFieldEnums, bool>? isObscure,
  }) {
    return TextFieldState(
      texts: texts ?? this.texts,
      isValid: isValid ?? this.isValid,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  /// Reset all textfields
  TextFieldState reset() => const TextFieldState();

  @override
  List<Object?> get props => [texts, isValid, isObscure];
}
