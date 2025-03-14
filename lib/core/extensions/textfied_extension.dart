import '../constants/enums/text_field_enums.dart';
import '../controllers/models/textfields_state_model.dart';

extension TextFieldStateExtension on TextFieldState {
  /// Returns the value of the entered enum value
  String getTextByEnum(TextFieldEnums key) {
    return texts[key] ?? ''; 
  }
}
