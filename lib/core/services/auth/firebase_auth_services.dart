import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import '../../errors/failure_types/failure_types.dart';
import '../../errors/failures/failure.dart';
import 'i_auth_services.dart';

class AuthService implements IAuthService {
  final FirebaseFirestore _firestore;

  AuthService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// **Registers a new user in Firestore with Auto-ID**
  @override
  Future<Either<Failure, String>> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {

    try {
      final usersCollection = _firestore.collection('users');

      /// **Check if the email is already registered**
      final emailCheck =
          await usersCollection.where('email', isEqualTo: email).get();
      if (emailCheck.docs.isNotEmpty) {
        return Left(CacheFailure('This email is already registered'));
      }

      /// **Check if the username is already taken**
      final usernameCheck =
          await usersCollection.where('username', isEqualTo: username).get();
      if (usernameCheck.docs.isNotEmpty) {
        return Left(CacheFailure('This username is already taken'));
      }

      /// **Hash the password using bcrypt for security**
      final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

      /// **Save the user in Firestore with an auto-generated ID**
      final docRef = await usersCollection.add({
        'username': username,
        'email': email,
        'password': hashedPassword,
      });

      return Right(docRef.id); // ✅ Return the Auto-ID
    } catch (e) {
      return Left(CacheFailure('Registration failed: ${e.toString()}'));
    }
  }

  /// **Logs in a user by validating credentials from Firestore**
  @override
  Future<Either<Failure, String>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final usersCollection = _firestore.collection('users');

      /// **Find user by email**
      final querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        return Left(CacheFailure('User not found'));
      }

      final userData = querySnapshot.docs.first.data();

      /// **Validate password using bcrypt**
      if (!BCrypt.checkpw(password, userData['password'])) {
        return Left(CacheFailure('Incorrect password'));
      }

      return Right('Login Successful');
    } catch (e) {
      return Left(CacheFailure('Login failed: ${e.toString()}'));
    }
  }

  /// **Manually logs out the user**
  @override
  Future<void> signOut() async {
    debugPrint("User signed out");
  }
}
