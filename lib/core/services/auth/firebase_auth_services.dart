import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duo_app/core/models/user/user_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import '../../errors/failure_types/failure_types.dart';
import '../../errors/failures/failure.dart';
import 'i_auth_services.dart';

class AuthService implements IAuthService {
  final FirebaseFirestore _firestore;

  AuthService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Registers a new user in Firestore with an auto-generated ID.
  @override
  Future<Either<Failure, String>> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final usersCollection = _firestore.collection('users');

      // Check if the email or username is already registered.
      final userCheck = await usersCollection
          .where(Filter.or(
            Filter("email", isEqualTo: email),
            Filter("username", isEqualTo: username),
          ))
          .get();

      if (userCheck.docs.isNotEmpty) {
        return Left(CacheFailure('Email or Username is already taken'));
      }

      // Hash the password using bcrypt.
      final hashedPassword =
          BCrypt.hashpw(password, BCrypt.gensalt(logRounds: 10));

      // Save the user in Firestore.
      final docRef = await usersCollection.add({
        'username': username,
        'email': email,
        'password': hashedPassword,
      });

      // Update Firestore document with its ID.
      await usersCollection.doc(docRef.id).update({'userId': docRef.id});

      return Right(docRef.id);
    } catch (e) {
      return Left(CacheFailure('Registration failed: ${e.toString()}'));
    }
  }

  /// Logs in a user by validating credentials from Firestore.
  @override
  Future<Either<Failure, UserModel>> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      final usersCollection = _firestore.collection('users');

      // Find user by username.
      final querySnapshot =
          await usersCollection.where('username', isEqualTo: username).get();

      if (querySnapshot.docs.isEmpty) {
        return Left(CacheFailure('Invalid credentials'));
      }

      final doc = querySnapshot.docs.first;
      final userData = doc.data();

      // Validate password using bcrypt.
      if (!BCrypt.checkpw(password, userData['password'])) {
        return Left(CacheFailure('Invalid credentials'));
      }

      // Convert Firestore data to UserModel.
      final user = UserModel.fromMap({
        ...userData,
        'userId': doc.id,
      });
      debugPrint("Input password: $password");
      debugPrint("Stored hash: ${userData['password']}");
      return Right(user);
    } catch (e) {
      return Left(CacheFailure('Login failed: ${e.toString()}'));
    }
  }

  /// Retrieves user data from Firestore.
  @override
  Future<Either<Failure, UserModel>> getUserData(String username) async {
    try {
      final usersCollection = _firestore.collection('users');
      final querySnapshot =
          await usersCollection.where('username', isEqualTo: username).get();

      if (querySnapshot.docs.isEmpty) {
        return Left(CacheFailure('User not found'));
      }

      return Right(UserModel.fromMap(querySnapshot.docs.first.data()));
    } catch (e) {
      return Left(
          CacheFailure('Failed to retrieve user data: ${e.toString()}'));
    }
  }

  /// Checks if a user exists by email or username.
  @override
  Future<Either<Failure, bool>> checkUserExists(
      String email, String username) async {
    try {
      final usersCollection = _firestore.collection('users');
      final userCheck = await usersCollection
          .where(Filter.or(
            Filter("email", isEqualTo: email),
            Filter("username", isEqualTo: username),
          ))
          .get();

      return Right(userCheck.docs.isNotEmpty);
    } catch (e) {
      return Left(
          ServerFailure("Error checking user existence: ${e.toString()}"));
    }
  }

  /// Signs out the current user.
  @override
  Future<void> signOut() async {
    debugPrint("User signed out");
  }
}
