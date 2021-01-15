import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as socket_status;

class WebSocketClient {
  final Logger _log = Logger('WebSocketClient');

  /// connection details
  String _host;
  Map<String, dynamic> _headers;
  int _pingInterval = 10;

  /// instances details.
  IOWebSocketChannel _connection;
  bool _expectedDisconnect = false;

  /// Keep the same instance alive
  static WebSocketClient _instance;
  factory WebSocketClient() {
    if (_instance != null) {
      return _instance;
    }

    return _instance ??= WebSocketClient._();
  }

  WebSocketClient._();

  /// connect to the web socket server defined in [host].
  Future connect({
    @required String host,
    Map<String, dynamic> headers,
    int pingInterval = 10,
  }) async {
    /// reset the bool describing if we disconnect if it was intentional
    _expectedDisconnect = false;

    /// save the settings in case we need to reconnect
    _host = host;
    _headers = headers;
    _pingInterval = pingInterval;

    /// connect to the server
    _connection = IOWebSocketChannel.connect(
      _host,
      headers: _headers,
      pingInterval: Duration(seconds: _pingInterval),
    );

    _log.log(Level.INFO, '''
      
  --------- WEB SOCKET :: CONNECT ---------
  host: $host
  Headers: ${headers.toString()}
  Ping Interval: $pingInterval
  --------------------------------''');

    /// setup message listener
    _connection.stream.listen(handleMessage);

    /// setup error listener
    _connection.stream.handleError(handleError);

    _checkConnection();
  }

  /// disconnect web socket client
  void disconnect() {
    _log.log(Level.INFO, '------ WEB SOCKET :: DISCONNECT ------');

    _expectedDisconnect = true;
    _connection.sink.close(socket_status.normalClosure);
  }

  /// Check if the connection still exists
  Future _checkConnection() async {
    await Future.delayed(
      Duration(seconds: _pingInterval),
    );

    if (_connection.closeCode != null && !_expectedDisconnect) {
      _log.log(Level.INFO, '------ WEB SOCKET :: RECONNECTING ------');

      connect(
        host: _host,
        pingInterval: _pingInterval,
        headers: _headers,
      );
    } else {
      _checkConnection();
    }
  }

  /// Handle web socket messages
  void handleMessage(dynamic message) {
    _log.log(Level.INFO, '''
      
    --------- WEB SOCKET :: MESSAGE ---------
    ${message.toString()}
    -----------------------------------------''');
  }

  /// handle web socket errors
  void handleError(dynamic message) {
    _log.log(Level.SEVERE, '''
      
    --------- WEB SOCKET :: ERROR ---------
    ${message.toString()}
    ---------------------------------------''');
  }
}
