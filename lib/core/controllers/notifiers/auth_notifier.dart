import 'dart:math';
import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dependency_injection/di.dart';
import '../../errors/failure.dart';
import '../../services/auth/firebase_auth_services.dart';
import '../providers/indicator_provider.dart';
import '_base_notifier.dart';
import '../models/auth_state_model.dart';

class AuthNotifier extends BaseNotifier<AuthState> {
  final Ref ref;
  final authService = getIt<AuthService>();

  AuthNotifier(this.ref) : super(AuthState());

  /// Retrieves the generated OTP code.
  String get getCode => state.otpCode;

  /// Generates a new OTP code and updates the state.
  void _generateOtpCode() {
    final random = Random();
    String otpCode = (1000 + random.nextInt(9000)).toString();
    updateState(state.copyWith(otpCode: otpCode, enteredCode: ""));
  }

  /// Resends the OTP code.
  void reGenerateCode() {
    _generateOtpCode();
  }

  /// Updates the OTP code entered by the user.
  void updateOtpCode(String code) {
    updateState(state.copyWith(enteredCode: code));
  }

  /// Validates the entered OTP code.
  bool _validateOtp(String enteredCode) {
    bool isValid = enteredCode == state.otpCode;
    debugPrint(isValid ? "OTP Verified!" : "OTP Incorrect!");
    return isValid;
  }

  /// Checks if the user exists in the database.
  Future<Either<Failure, bool>> _isUserExists(
      String email, String username) async {
    return await authService.checkUserExists(email, username);
  }

  /// Controls user existence and generates an OTP if the user does not exist.
  Future<bool> dbControl(String email, String password, String username) async {
    _setLoading(true);
    final userExistsResult = await _isUserExists(email, username);
    bool result = userExistsResult.fold(
      (failure) {
        debugPrint("User existence check failed: ");
        return false;
      },
      (userExists) {
        if (userExists) {
          // Kullanıcı veritabanında varsa false döndür
          debugPrint("User already exists in DB.");
          return false;
        } else {
          // Kullanıcı yoksa OTP oluştur ve true döndür
          _generateOtpCode();
          return true;
        }
      },
    );
    _setLoading(false);
    return result;
  }

  /// Completes user registration after OTP validation.
  Future<bool> register(String email, String password, String username) async {
    _setLoading(true);

    // Validate OTP.
    if (!_validateOtp(state.enteredCode)) {
      _setLoading(false);
      return false;
    }

    final result = await authService.registerUser(
      username: username,
      email: email,
      password: password,
    );

    bool isSuccess = result.isRight;
    debugPrint(isSuccess
        ? "User registration successful!"
        : "Registration Error: ${result.left}");
    _setLoading(false);
    return isSuccess;
  }

  /// Handles user login.
  Future<Either<Failure, dynamic>> loginUser(
      String username, String password) async {
    _setLoading(true);
    final result =
        await authService.loginUser(username: username, password: password);
     
       
    _setLoading(false);
    return result;
  }

  /// Handles user logout.
  void logout() {
    _setLoading(true);
    resetState(AuthState());
    _setLoading(false);
  }

  /// Sets loading state in both AuthState and Global Indicator Provider.
  void _setLoading(bool value) {
    updateState(state.copyWith(isLoading: value));
    ref.read(indicatorProvider.notifier).state = value;
  }
}
