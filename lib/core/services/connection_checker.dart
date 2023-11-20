import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Stream<bool>? get isConnected;
  Future<bool>? get hasConnection;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({required this.dataConnectionChecker});

  final InternetConnectionChecker dataConnectionChecker;

  @override
  Stream<bool> get isConnected async* {
    bool connected = false;
    await for (InternetConnectionStatus status
        in dataConnectionChecker.onStatusChange) {
      switch (status) {
        case InternetConnectionStatus.connected:
          connected = true;
          break;
        case InternetConnectionStatus.disconnected:
          connected = false;
          break;
      }
      yield connected;
    }
  }

  @override
  Future<bool> get hasConnection => dataConnectionChecker.hasConnection;
}
