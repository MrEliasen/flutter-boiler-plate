import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as socket_status;

class WebSocketClient {
  final Logger _log = Logger('WebSocketClient');

  /// connection details
  final String host;
  final Map<String, dynamic> headers;
  final int pingInterval;

  /// instances details.
  IOWebSocketChannel _connection;
  bool _expectedDisconnect = false;

  WebSocketClient({
    @required this.host,
    this.headers,
    this.pingInterval = 10,
  });

  /// connect to the web socket server defined in [host].
  Future connect() async {
    /// reset the bool describing if we disconnect if it was intentional
    _expectedDisconnect = false;

    /// connect to the server
    _connection = IOWebSocketChannel.connect(
      host,
      headers: headers,
      pingInterval: Duration(seconds: pingInterval),
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
      Duration(seconds: pingInterval),
    );

    if (_connection.closeCode != null && !_expectedDisconnect) {
      _log.log(Level.INFO, '------ WEB SOCKET :: RECONNECTING ------');

      connect();
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
