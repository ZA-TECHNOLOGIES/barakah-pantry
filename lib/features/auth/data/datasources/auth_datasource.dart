import '../models/auth_request_model.dart';
import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(AuthRequestModel request);
  Future<AuthResponseModel> signup(AuthRequestModel request);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // This is a placeholder implementation since the actual logic is currently in the Repository.
  // In a clean architecture, the repository should call this datasource.

  @override
  Future<AuthResponseModel> login(AuthRequestModel request) {
    throw UnimplementedError(
        'Login not implemented in datasource yet - using repository directly');
  }

  @override
  Future<AuthResponseModel> signup(AuthRequestModel request) {
    throw UnimplementedError(
        'Signup not implemented in datasource yet - using repository directly');
  }

  @override
  Future<void> logout() {
    throw UnimplementedError(
        'Logout not implemented in datasource yet - using repository directly');
  }
}
