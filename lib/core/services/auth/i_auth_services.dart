import 'package:duo_app/core/models/user/user_model.dart';
import 'package:either_dart/either.dart';
import '../../errors/failures/failure.dart';

/// Authentication service interface without FirebaseAuth.
abstract class IAuthService {
  /// Registers a new user (manual method) and returns the generated document ID.
  Future<Either<Failure, String>> registerUser({
    required String username,
    required String email,
    required String password,
  });

  /// Checks if a user exists by email or username.
  Future<Either<Failure, bool>> checkUserExists(String email, String username);

  /// Logs in a user (manual method).
  Future<Either<Failure, UserModel>> loginUser({
    required String username,
    required String password,
  });

  /// User data fecthing after login
 Future<Either<Failure, UserModel>> getUserData(String username);

  /// Signs out the current user.
  Future<void> signOut();
}
