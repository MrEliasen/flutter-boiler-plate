import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as socket_status;

class WebSocketClient {
  final Logger _log = Logger('WebSocketClient');

  /// connection details
  String _host;
  Map<String, dynamic> _headers;
  int _pingInterval;

  /// instances details.
  IOWebSocketChannel _connection;
  bool _expectedDisconnect = false;

  /// notification channel
  StreamController _messageStream;
  Stream<dynamic> get messages => _messageStream.stream;

  /// errors channel
  StreamController _errorStream;
  Stream<dynamic> get errors => _errorStream.stream;

  WebSocketClient({
    @required String host,
    Map<String, dynamic> headers,
    int pingInterval = 10,
  }) {
    _host = host;
    _headers = headers;
    _pingInterval = pingInterval;

    /// create the notification stream
    _messageStream = StreamController.broadcast();
    _errorStream = StreamController.broadcast();
  }

  /// connect to the web socket server defined in [_host].
  Future connect() async {
    /// reset the bool describing if we disconnect if it was intentional
    _expectedDisconnect = false;

    /// connect to the server
    _connection = IOWebSocketChannel.connect(
      Uri.parse(_host),
      headers: _headers,
      pingInterval: Duration(seconds: _pingInterval),
    );

    _log.log(Level.INFO, '''
      
  --------- WEB SOCKET :: CONNECT ---------
  host: $_host
  Headers: ${_headers.toString()}
  Ping Interval: $_pingInterval
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

    _messageStream.sink.add(message);
  }

  /// handle web socket errors
  void handleError(dynamic message) {
    _log.log(Level.SEVERE, '''
      
    --------- WEB SOCKET :: ERROR ---------
    ${message.toString()}
    ---------------------------------------''');

    _errorStream.sink.add(message);
  }
}
