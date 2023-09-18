import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  Future<T> handleConnection<T>(
      {required Future<T> Function() onConnected,
      required Future<T> Function() onNotConnected});
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async => await connectionChecker.hasConnection;

  @override
  Future<T> handleConnection<T>(
      {required Future<T> Function() onConnected,
      required Future<T> Function() onNotConnected}) async {
    if (await isConnected) {
      return onConnected();
    } else {
      return onNotConnected();
    }
  }
}
