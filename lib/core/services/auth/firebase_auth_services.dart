import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duo_app/core/constants/enums/failure_types.dart';
import 'package:duo_app/core/extensions/failure_extension.dart';
import 'package:duo_app/core/models/user/user_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import '../../errors/failure_types.dart';
import '../../errors/failure.dart';
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
        return Left(FailureType.serverError.failure(message: "Sunucu hatası!"));
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
      //  return Left(CacheFailure('Registration failed: ${e.toString()}'));
      return Left(CacheFailure());
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
        return Left(ServerFailure(details: "Invalid credentials"));
        //  return Left(CacheFailure('Invalid credentials'));
      }

      final doc = querySnapshot.docs.first;
      final userData = doc.data();

      // Validate password using bcrypt.
      if (!BCrypt.checkpw(password, userData['password'])) {
        //        return Left(CacheFailure('Invalid credentials'));

        return Left(ServerFailure(details: "Invalid credentials"));
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
      //  return Left(CacheFailure('Login failed: ${e.toString()}'));
      return Left(ServerFailure(details: "Login Failed"));
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
        //user not found
        return Left(CacheFailure());
      }

      return Right(UserModel.fromMap(querySnapshot.docs.first.data()));
    } catch (e) {
      return Left(
          //          CacheFailure('Failed to retrieve user data: ${e.toString()}'));

          CacheFailure());
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
          //Error checking user existence:
          ServerFailure(details: e.toString()));
    }
  }

  /// Signs out the current user.
  @override
  Future<void> signOut() async {
    debugPrint("User signed out");
  }
}
