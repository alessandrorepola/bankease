import 'package:bankease/core/failures/failures.dart';
import 'package:bankease/features/requests/domain/entities/request.dart';
import 'package:bankease/features/requests/domain/use_cases/add_request_use_case.dart';
import 'package:dartz/dartz.dart';

/// {@template RequestRepo}
/// The interface for an API that provides access to a list of requests.
/// {@endtemplate}
abstract class RequestsRepo {
  /// Provides a [Stream] of all requests.
  Stream<List<Request>> getRequests();

  /// Return the `request` with the given id.
  ///
  /// If no `todo` with the given id exists, a [RequestNotFoundFailure] return.
  Future<Either<Failure, Request>> getRequestById(String id);

  /// Add a new [Request].
  ///
  /// Use only the required parameters to create a new request, specified with [AddRequestParams]
  /// The id of request is automatically created
  /// If a [Request] is add saccesfully return [Request]
  Future<Either<Failure, Request>> add(AddRequestParams addRequestParams);

  /// Saves changes of a [Request] .
  ///
  /// If a [Request] with the same id already exists, it will be replaced.
  /// If a [Request] didn't save succesfully return [RequestNotFoundFailure]
  Future<Either<Failure, Unit>> save(Request request);

  /// Deletes the `request` with the given id.
  ///
  /// If no `request` with the given id exists, a [RequestNotFoundFailure] return.
  Future<Either<Failure, Unit>> delete(String id);
}

/// Error when a [Request] with a given id is not found.
class RequestNotFoundFailure implements Failure {}
