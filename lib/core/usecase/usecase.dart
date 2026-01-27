import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Base UseCase class
/// All use cases should extend this class
///
/// [Type] is the return type of the use case
/// [Params] is the input parameters type
abstract class UseCase<Type, Params> {
  /// Execute the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// No Parameters class
/// Use this when the use case doesn't require any parameters
class NoParams {
  const NoParams();
}

/// Pagination Parameters
/// Common parameters for paginated requests
class PaginationParams {
  final int page;
  final int limit;
  final String? sortBy;
  final bool ascending;

  const PaginationParams({
    this.page = 1,
    this.limit = 20,
    this.sortBy,
    this.ascending = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'limit': limit,
      if (sortBy != null) 'sort_by': sortBy,
      'ascending': ascending,
    };
  }
}

/// ID Parameter
/// Common parameter for single ID requests
class IdParams {
  final String id;

  const IdParams({required this.id});
}

/// Search Parameters
/// Common parameters for search requests
class SearchParams {
  final String query;
  final int page;
  final int limit;
  final Map<String, dynamic>? filters;

  const SearchParams({
    required this.query,
    this.page = 1,
    this.limit = 20,
    this.filters,
  });
}
