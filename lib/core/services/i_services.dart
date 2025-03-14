import 'package:either_dart/either.dart';
import '../errors/failure.dart';

/// Common service interface for both Firebase and other APIs.
/// [T] → Represents the type of data returned on a successful operation.
abstract class IServices {
  
  /// **Fetches data from the specified endpoint.**
  /// - For Firebase: Retrieves a document in "collection/docId" format. If no document is specified, a collection query is performed.
  /// - [fromJson] function converts the obtained data to type `T`.
  Future<Either<Failure, T>> fetch<T>(
    String endpoint, {
    Map<String, dynamic>? params,
    bool useCache = true,
    required T Function(dynamic json) fromJson,
  });

  /// **Creates a new document (CREATE)**
  /// - Adds a new document to the specified endpoint.
  Future<Either<Failure, T>> create<T>(
    String endpoint, {
    required Map<String, dynamic> data,
    required T Function(dynamic json) fromJson,
  });

  /// **Updates an existing document (UPDATE)**
  /// - Replaces or modifies an entire document.
  Future<Either<Failure, T>> update<T>(
    String endpoint, {
    required Map<String, dynamic> data,
    required T Function(dynamic json) fromJson,
  });

  /// **Updates specific fields of a document (PATCH)**
  /// - Updates only certain fields instead of replacing the entire document.
  Future<Either<Failure, T>> patch<T>(
    String endpoint, {
    required Map<String, dynamic> data,
    required T Function(dynamic json) fromJson,
  });

  
  /// **Deletes a document and returns the deleted data.**
  /// - If the document does not exist, returns `Left(Failure)`.
  Future<Either<Failure, Map<String, dynamic>>> delete(String endpoint);

  /// **Clears the cache stored in memory or persistent storage.**
  void clearCache();
}
