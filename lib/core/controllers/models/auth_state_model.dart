import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String userName;
  final String password;
  final String enteredCode;
  final String otpCode;
  final bool isLoading;

  const AuthState({
    this.userName = "",
    this.password = "",
    this.enteredCode = "",
    this.otpCode = "",
    this.isLoading=false,
  });

  /// Update only changed data
  AuthState copyWith({
    String? userName,
    String? password,
    String? enteredCode,
    String? otpCode,
    bool? isLoading,
  }) {
    return AuthState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      enteredCode: enteredCode ?? this.enteredCode,
      otpCode: otpCode ?? this.otpCode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [userName, password, enteredCode, otpCode, isLoading];
}
