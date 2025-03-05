import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceWebSocketService {
  static const String _baseUrl = 'wss://stream.binance.com:9443/ws';
  WebSocketChannel? _channel;
  final StreamController<Map<String, dynamic>> _streamController =
      StreamController.broadcast();

  Stream<Map<String, dynamic>> get stream => _streamController.stream;

  void connectToCandlestickStream(String symbol, String interval) {
    final url = '$_baseUrl/${symbol.toLowerCase()}@kline_$interval';
    _channel = IOWebSocketChannel.connect(url);

    _channel?.stream.listen(
      (data) {
        final parsedData = json.decode(data);
        _streamController.add(parsedData);
      },
      onDone: () {
        print('WebSocket connection closed');
        reconnect(symbol, interval);
      },
      onError: (error) {
        print('WebSocket error: $error');
        reconnect(symbol, interval);
      },
    );
  }

  void connectToOrderbookStream(String symbol) {
    final url = '$_baseUrl/${symbol.toLowerCase()}@depth';
    _channel = IOWebSocketChannel.connect(url);

    _channel?.stream.listen(
      (data) {
        final parsedData = json.decode(data);
        _streamController.add(parsedData);
      },
      onDone: () {
        print('WebSocket connection closed');
        reconnect(symbol);
      },
      onError: (error) {
        print('WebSocket error: $error');
        reconnect(symbol);
      },
    );
  }

  void reconnect(String symbol, [String? interval]) {
    disconnect();
    if (interval != null) {
      connectToCandlestickStream(symbol, interval);
    } else {
      connectToOrderbookStream(symbol);
    }
  }

  void disconnect() {
    _channel?.sink.close();
  }

  void dispose() {
    _streamController.close();
    disconnect();
  }
}
