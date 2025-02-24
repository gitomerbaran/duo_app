import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String username;
  final String userId;
  final List<Object> gameAccounts;

  const UserModel({
    required this.username,
    required this.userId,
    this.gameAccounts = const [],
  });

  UserModel copyWith({
    String? username,
    String? userId,
    List<Object>? gameAccounts,
  }) {
    return UserModel(
      username: username ?? this.username,
      userId: userId ?? this.userId,
      // Immutable list usage
      gameAccounts: gameAccounts ?? List.from(this.gameAccounts),
    );
  }

  @override
  List<Object?> get props => [username, userId, gameAccounts];
}
