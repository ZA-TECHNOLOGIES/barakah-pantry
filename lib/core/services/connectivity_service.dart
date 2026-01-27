import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:barakah_pantry/core/utils/helpers/ui_helper.dart';
import 'package:get/get.dart';

/// Connectivity Service Interface
abstract class ConnectivityService {
  /// Check if device is connected
  Future<bool> get isConnected;

  /// Get current connectivity status
  Future<List<ConnectivityResult>> get status;

  /// Stream of connectivity changes
  Stream<List<ConnectivityResult>> get onStatusChange;

  /// Check if connected to WiFi
  Future<bool> get isWifi;

  /// Check if connected to mobile data
  Future<bool> get isMobile;
}

/// Connectivity Service Implementation
class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity connectivity;

  ConnectivityServiceImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result.isNotEmpty && !result.contains(ConnectivityResult.none);
  }

  @override
  Future<List<ConnectivityResult>> get status async {
    return await connectivity.checkConnectivity();
  }

  @override
  Stream<List<ConnectivityResult>> get onStatusChange {
    return connectivity.onConnectivityChanged;
  }

  @override
  Future<bool> get isWifi async {
    final result = await connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.wifi);
  }

  @override
  Future<bool> get isMobile async {
    final result = await connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.mobile);
  }
}

/// Connectivity Controller
/// GetX controller for managing connectivity state
class ConnectivityController extends GetxController {
  final ConnectivityService _service;

  final _isConnected = true.obs;
  final _status = <ConnectivityResult>[ConnectivityResult.none].obs;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityController(this._service);

  bool get isConnected => _isConnected.value;
  List<ConnectivityResult> get status => _status.toList();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  Future<void> _init() async {
    // Get initial status
    _status.value = await _service.status;
    _isConnected.value =
        _status.isNotEmpty && !_status.contains(ConnectivityResult.none);

    // Listen to changes
    _subscription = _service.onStatusChange.listen((result) {
      final wasConnected = _isConnected.value;
      _status.value = result;
      _isConnected.value =
          result.isNotEmpty && !result.contains(ConnectivityResult.none);

      // Show snackbar on connection change
      if (!_isConnected.value && wasConnected) {
        _showNoConnectionSnackbar();
      } else if (_isConnected.value && !wasConnected) {
        _showConnectedSnackbar();
      }
    });
  }

  void _showNoConnectionSnackbar() {
    UIHelper.showSnackbar(
      title: 'No Connection',
      message: 'Please check your internet connection',
    );
  }

  void _showConnectedSnackbar() {
    UIHelper.showSnackbar(
      title: 'Connected',
      message: 'You are back online',
    );
  }

  /// Check connection and return result
  Future<bool> checkConnection() async {
    _isConnected.value = await _service.isConnected;
    return _isConnected.value;
  }
}
