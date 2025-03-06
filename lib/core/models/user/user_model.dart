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

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      userId: map['userId'] as String,
      gameAccounts: List<String>.from(map['gameAccounts'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId': userId,
      'gameAccounts': gameAccounts,
    };
  }

  @override
  List<Object?> get props => [username, userId, gameAccounts];
}
