import '../constants/enums/failure_types.dart';
import '../errors/failure_types.dart';
import '../errors/failure.dart';

extension FailureTypeExtension on FailureType {
  Failure failure({String? message}) {
    switch (this) {
      case FailureType.versionError:
        return const NetworkFailure();
      case FailureType.versionInfo:
        return const NetworkFailure();
      case FailureType.networkError:
        return const NetworkFailure();
      case FailureType.serverError:
        return ServerFailure(details: message);
      case FailureType.userExists:
        return const UserAlreadyExistsFailure();
      default:
        return UnknownFailure(message: message!);
    }
  }
}
