import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import '../errors/failure_types/failure_types.dart';
import '../errors/failures/failure.dart';
import 'i_services.dart';

/// Firebase implementation of IServices.
/// Supports CRUD operations with Firestore.
class FirebaseService implements IServices {
  final FirebaseFirestore _firestore;

  FirebaseService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Parses the endpoint to extract collection and document ID.
  Map<String, String> _parseEndpoint(String endpoint) {
    final parts = endpoint.split('/');
    return {
      'collection': parts.isNotEmpty ? parts[0] : '',
      'docId': parts.length > 1 ? parts[1] : '',
    };
  }

  @override
  Future<Either<Failure, T>> fetch<T>(
    String endpoint, {
    Map<String, dynamic>? params,
    bool useCache = true,
    required T Function(dynamic json) fromJson,
  }) async {
    final parsed = _parseEndpoint(endpoint);

    try {
      if (parsed['docId']!.isNotEmpty) {
        final docSnapshot = await _firestore
            .collection(parsed['collection']!)
            .doc(parsed['docId'])
            .get();

        if (!docSnapshot.exists) {
          return Left(CacheFailure('Document not found: $endpoint'));
        }

        final data = docSnapshot.data();
        if (data == null) {
          return Left(CacheFailure('Document is empty: $endpoint'));
        }

        final result = fromJson(data);
        return Right(result);
      } else {
        // Collection query
        Query query = _firestore.collection(parsed['collection']!);
        params?.forEach((key, value) {
          query = query.where(key, isEqualTo: value);
        });

        final querySnapshot = await query.get();
        final result = querySnapshot.docs.map((doc) => fromJson(doc.data())).toList();

        return Right(result as T);
      }
    } catch (e) {
      return Left(CacheFailure('Fetch error: ${e.toString()}'));
    }
  }

  /// **Creates a new document in Firestore.**
  @override
  Future<Either<Failure, T>> create<T>(
    String endpoint, {
    required Map<String, dynamic> data,
    required T Function(dynamic json) fromJson,
  }) async {
    return await _send(endpoint, method: 'POST', data: data, fromJson: fromJson);
  }

  /// **Updates an existing document in Firestore.**
  @override
  Future<Either<Failure, T>> update<T>(
    String endpoint, {
    required Map<String, dynamic> data,
    required T Function(dynamic json) fromJson,
  }) async {
    return await _send(endpoint, method: 'PUT', data: data, fromJson: fromJson);
  }

  /// **Applies partial updates to a document in Firestore.**
  @override
  Future<Either<Failure, T>> patch<T>(
    String endpoint, {
    required Map<String, dynamic> data,
    required T Function(dynamic json) fromJson,
  }) async {
    return await _send(endpoint, method: 'PATCH', data: data, fromJson: fromJson);
  }

  /// **Handles Firestore document creation and updates.**
  Future<Either<Failure, T>> _send<T>(
    String endpoint, {
    required String method,
    required Map<String, dynamic> data,
    required T Function(dynamic json) fromJson,
  }) async {
    final parsed = _parseEndpoint(endpoint);

    try {
      if (parsed['docId']!.isNotEmpty) {
        final docRef = _firestore.collection(parsed['collection']!).doc(parsed['docId']);
        final docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          if (method == 'PUT') {
            await docRef.set(data, SetOptions(merge: true));
          } else if (method == 'PATCH') {
            await docRef.update(data);
          } else {
            return Left(CacheFailure('Invalid HTTP method: $method'));
          }
        } else {
          await docRef.set(data);
        }

        final updatedSnapshot = await docRef.get();
        final newData = updatedSnapshot.data();

        if (newData == null) {
          return Left(CacheFailure('No data after operation: $endpoint'));
        }

        final result = fromJson(newData);
        return Right(result);
      } else {
        // Collection-based operation (only for creating new documents)
        final collectionRef = _firestore.collection(parsed['collection']!);
        final docRef = await collectionRef.add(data);
        final newSnapshot = await docRef.get();
        final newData = newSnapshot.data();

        if (newData == null) {
          return Left(CacheFailure('New document data not available: $endpoint'));
        }

        final result = fromJson(newData);
        return Right(result);
      }
    } catch (e) {
      return Left(CacheFailure('Send error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> delete(String endpoint) async {
    final parsed = _parseEndpoint(endpoint);

    if (parsed['docId']!.isEmpty) {
      return Left(CacheFailure('Document ID must be specified for deletion: $endpoint'));
    }

    try {
      final docRef = _firestore.collection(parsed['collection']!).doc(parsed['docId']);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        return Left(CacheFailure('Document not found: $endpoint'));
      }

      final oldData = docSnapshot.data();
      await docRef.delete();

      return Right(oldData ?? {});
    } catch (e) {
      return Left(CacheFailure('Delete error: ${e.toString()}'));
    }
  }

  @override
  void clearCache() {
    // Placeholder for future cache integration
  }

}
