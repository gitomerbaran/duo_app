import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String userName;
  final String password;
  final bool isLoading;

  const AuthState({
    this.userName = "",
    this.password = "",
    this.isLoading = false,
  });

  /// Update only changed data
  AuthState copyWith({
    String? userName,
    String? password,
    bool? isLoading,
  }) {
    return AuthState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [userName, password, isLoading];
}
