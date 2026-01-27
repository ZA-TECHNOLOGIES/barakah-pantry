import 'package:connectivity_plus/connectivity_plus.dart';

/// Network Info Interface
/// Abstracts network connectivity checking
abstract class NetworkInfo {
  /// Check if device is connected to internet
  Future<bool> get isConnected;

  /// Get current connectivity status
  Future<List<ConnectivityResult>> get connectivityResult;

  /// Stream of connectivity changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

/// Network Info Implementation
/// Uses connectivity_plus package to check network status
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result.isNotEmpty && !result.contains(ConnectivityResult.none);
  }

  @override
  Future<List<ConnectivityResult>> get connectivityResult async {
    return await connectivity.checkConnectivity();
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return connectivity.onConnectivityChanged;
  }
}
