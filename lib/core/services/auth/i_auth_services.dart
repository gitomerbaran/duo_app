import 'package:either_dart/either.dart';
import '../../errors/failures/failure.dart';

/// **Authentication service interface without FirebaseAuth**
abstract class IAuthService {
  /// **Registers a new user (manual method)**
  Future<Either<Failure, void>> registerUser({
    required String username,
    required String email,
    required String password,
  });

  /// **Logs in a user (manual method)**
  Future<Either<Failure, String>> loginUser({
    required String email,
    required String password,
  });

  /// **Signs out the current user**
  Future<void> signOut();
}
