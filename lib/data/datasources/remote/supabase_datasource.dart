import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/errors/exceptions.dart' hide StorageException;

/// Supabase Datasource Interface
abstract class SupabaseDatasource {
  // Generic CRUD operations
  Future<List<Map<String, dynamic>>> getAll(
    String table, {
    String? select,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  });

  Future<Map<String, dynamic>?> getById(
    String table,
    String id, {
    String? select,
  });

  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  );

  Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  );

  Future<void> delete(String table, String id);

  Future<List<Map<String, dynamic>>> search(
    String table,
    String column,
    String query, {
    String? select,
    int? limit,
  });

  // RPC calls
  Future<dynamic> rpc(String function, {Map<String, dynamic>? params});

  // Storage
  Future<String> uploadFile(
    String bucket,
    String path,
    List<int> bytes, {
    String? contentType,
  });

  Future<void> deleteFile(String bucket, String path);

  String getPublicUrl(String bucket, String path);
}

/// Supabase Datasource Implementation
class SupabaseDatasourceImpl implements SupabaseDatasource {
  final SupabaseClient client;

  SupabaseDatasourceImpl({required this.client});

  //═══════════════════════════════════════════════════════════════
  // GET ALL
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<Map<String, dynamic>>> getAll(
    String table, {
    String? select,
    Map<String, dynamic>? filters,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      dynamic query = client.from(table).select(select ?? '*');

      // Apply filters
      if (filters != null) {
        filters.forEach((key, value) {
          if (value is List) {
            query = query.inFilter(key, value);
          } else if (value is Map) {
            // Handle special operators
            value.forEach((operator, operatorValue) {
              switch (operator) {
                case 'eq':
                  query = query.eq(key, operatorValue);
                  break;
                case 'neq':
                  query = query.neq(key, operatorValue);
                  break;
                case 'gt':
                  query = query.gt(key, operatorValue);
                  break;
                case 'gte':
                  query = query.gte(key, operatorValue);
                  break;
                case 'lt':
                  query = query.lt(key, operatorValue);
                  break;
                case 'lte':
                  query = query.lte(key, operatorValue);
                  break;
                case 'like':
                  query = query.like(key, operatorValue);
                  break;
                case 'ilike':
                  query = query.ilike(key, operatorValue);
                  break;
                case 'is':
                  query = query.isFilter(key, operatorValue);
                  break;
              }
            });
          } else {
            query = query.eq(key, value);
          }
        });
      }

      // Apply ordering
      if (orderBy != null) {
        query = query.order(orderBy, ascending: ascending);
      }

      // Apply pagination
      if (limit != null) {
        final start = offset ?? 0;
        query = query.range(start, start + limit - 1);
      }

      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch data from $table',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY ID
  //═══════════════════════════════════════════════════════════════

  @override
  Future<Map<String, dynamic>?> getById(
    String table,
    String id, {
    String? select,
  }) async {
    try {
      final response = await client
          .from(table)
          .select(select ?? '*')
          .eq('id', id)
          .maybeSingle();

      return response;
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return null; // Not found
      }
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch record from $table',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // INSERT
  //═══════════════════════════════════════════════════════════════

  @override
  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await client.from(table).insert(data).select().single();

      return response;
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to insert record into $table',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // UPDATE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response =
          await client.from(table).update(data).eq('id', id).select().single();

      return response;
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to update record in $table',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // DELETE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> delete(String table, String id) async {
    try {
      await client.from(table).delete().eq('id', id);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete record from $table',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // SEARCH
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<Map<String, dynamic>>> search(
    String table,
    String column,
    String query, {
    String? select,
    int? limit,
  }) async {
    try {
      dynamic request =
          client.from(table).select(select ?? '*').ilike(column, '%$query%');

      if (limit != null) {
        request = request.limit(limit);
      }

      final response = await request;
      return List<Map<String, dynamic>>.from(response);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to search in $table',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // RPC (Remote Procedure Call)
  //═══════════════════════════════════════════════════════════════

  @override
  Future<dynamic> rpc(String function, {Map<String, dynamic>? params}) async {
    try {
      final response = await client.rpc(function, params: params);
      return response;
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to call function $function',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // STORAGE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<String> uploadFile(
    String bucket,
    String path,
    List<int> bytes, {
    String? contentType,
  }) async {
    try {
      await client.storage.from(bucket).uploadBinary(
            path,
            bytes as dynamic,
            fileOptions: FileOptions(
              contentType: contentType,
              upsert: true,
            ),
          );

      return getPublicUrl(bucket, path);
    } on StorageException catch (e) {
      throw Exception('Upload failed: ${e.message}');
    } catch (e) {
      throw Exception('Upload failed: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteFile(String bucket, String path) async {
    try {
      await client.storage.from(bucket).remove([path]);
    } on StorageException catch (e) {
      throw Exception('Delete failed: ${e.message}');
    } catch (e) {
      throw Exception('Delete failed: ${e.toString()}');
    }
  }

  @override
  String getPublicUrl(String bucket, String path) {
    return client.storage.from(bucket).getPublicUrl(path);
  }
}
