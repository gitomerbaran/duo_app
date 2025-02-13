// core/errors/failure_extension.dart
import '../constants/enums/failure_types.dart';

extension FailureExtension on FailureType {
  String get errorMessage {
    switch (this) {
      case FailureType.userNotFound:
        return "User not found!";
      case FailureType.tokenError:
        return "Invalid Token!";
      case FailureType.verificationFailed:
        return "Incorrect verify code!";
      case FailureType.unexpectedError:
        return "An unexpected error occurred!";
      case FailureType.cacheError:
        return "Cache Error";
      case FailureType.serverError:
        return "Connection Error";
    }
  }
}
