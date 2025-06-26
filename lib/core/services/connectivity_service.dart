import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service for monitoring network connectivity status
class ConnectivityService {
  ConnectivityService._();

  static final _instance = ConnectivityService._();
  static ConnectivityService get instance => _instance;

  final _connectivity = Connectivity();
  final _statusController = StreamController<ConnectivityStatus>.broadcast();

  ConnectivityStatus _currentStatus = ConnectivityStatus.unknown;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// Current connectivity status
  ConnectivityStatus get currentStatus => _currentStatus;

  /// Stream of connectivity status changes
  Stream<ConnectivityStatus> get statusStream => _statusController.stream;

  /// Check if device is currently online
  bool get isOnline => _currentStatus == ConnectivityStatus.connected;

  /// Check if device is currently offline
  bool get isOffline => _currentStatus == ConnectivityStatus.disconnected;

  /// Initialize connectivity monitoring
  Future<void> initialize() async {
    // Get initial connectivity status
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);

    // Listen to connectivity changes
    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  /// Dispose resources
  void dispose() {
    _subscription?.cancel();
    _statusController.close();
  }

  /// Update connectivity status based on connectivity result
  void _updateStatus(List<ConnectivityResult> results) {
    final newStatus = _determineStatus(results);

    if (newStatus != _currentStatus) {
      final previousStatus = _currentStatus;
      _currentStatus = newStatus;

      _statusController.add(newStatus);

      if (kDebugMode) {
        print(
          'Connectivity changed: ${previousStatus.name} -> ${newStatus.name}',
        );
      }
    }
  }

  /// Determine connectivity status from connectivity results
  ConnectivityStatus _determineStatus(List<ConnectivityResult> results) {
    if (results.isEmpty) {
      return ConnectivityStatus.unknown;
    }

    // Check if any connection type indicates connectivity
    for (final result in results) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.vpn:
          return ConnectivityStatus.connected;
        case ConnectivityResult.bluetooth:
        case ConnectivityResult.none:
        case ConnectivityResult.other:
          continue;
      }
    }

    return ConnectivityStatus.disconnected;
  }

  /// Check actual internet connectivity (ping test)
  Future<bool> hasInternetConnection() async {
    try {
      // Simple connectivity check - in a real app, you might want to
      // ping your own server
      final result = await _connectivity.checkConnectivity();
      return _determineStatus(result) == ConnectivityStatus.connected;
    } on Exception {
      return false;
    }
  }

  /// Wait for internet connection to be restored
  Future<void> waitForConnection({Duration? timeout}) async {
    if (isOnline) {
      return;
    }

    final completer = Completer<void>();
    StreamSubscription<ConnectivityStatus>? subscription;
    Timer? timeoutTimer;

    subscription = statusStream.listen((status) {
      if (status == ConnectivityStatus.connected) {
        subscription?.cancel();
        timeoutTimer?.cancel();
        if (!completer.isCompleted) {
          completer.complete();
        }
      }
    });

    if (timeout != null) {
      timeoutTimer = Timer(timeout, () {
        subscription?.cancel();
        if (!completer.isCompleted) {
          completer.completeError(
            TimeoutException('Connection timeout', timeout),
          );
        }
      });
    }

    return completer.future;
  }
}

/// Connectivity status enumeration
enum ConnectivityStatus {
  /// Connected to internet
  connected,

  /// Disconnected from internet
  disconnected,

  /// Connection status unknown
  unknown,
}

/// Riverpod provider for ConnectivityService
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService.instance;
});

/// Riverpod provider for connectivity status stream
final connectivityStatusProvider = StreamProvider<ConnectivityStatus>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.statusStream;
});

/// Riverpod provider for current connectivity status
final isOnlineProvider = Provider<bool>((ref) {
  final statusAsync = ref.watch(connectivityStatusProvider);
  return statusAsync.when(
    data: (status) => status == ConnectivityStatus.connected,
    loading: () => true, // Assume online while loading
    error: (_, _) => false,
  );
});

/// Exception thrown when connection times out
class TimeoutException implements Exception {
  const TimeoutException(this.message, this.duration);

  final String message;
  final Duration duration;

  @override
  String toString() =>
      'TimeoutException: $message (${duration.inMilliseconds}ms)';
}
