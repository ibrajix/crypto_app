import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'binance_web_socket_service.dart';

part 'websocket_provider.freezed.dart';

@freezed
class WebSocketState with _$WebSocketState {
  factory WebSocketState({
    @Default(null) dynamic candlestickData,
    @Default(null) dynamic orderbookData,
    @Default(false) bool isConnected,
  }) = _WebSocketState;
}

class WebSocketNotifier extends StateNotifier<WebSocketState> {
  final BinanceWebSocketService _webSocketService;

  WebSocketNotifier(this._webSocketService) : super(WebSocketState()) {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocketService.stream.listen((data) {
      if (data['e'] == 'kline') {
        state = state.copyWith(
          candlestickData: data,
          isConnected: true,
        );
      } else if (data['e'] == 'depthUpdate') {
        state = state.copyWith(
          orderbookData: data,
          isConnected: true,
        );
      }
    });
  }

  void connectToCandlestickStream(String symbol, String interval) {
    _webSocketService.connectToCandlestickStream(symbol, interval);
  }

  void connectToOrderbookStream(String symbol) {
    _webSocketService.connectToOrderbookStream(symbol);
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }
}

final webSocketServiceProvider = Provider((ref) => BinanceWebSocketService());

final webSocketProvider =
    StateNotifierProvider<WebSocketNotifier, WebSocketState>((ref) {
  final service = ref.watch(webSocketServiceProvider);
  return WebSocketNotifier(service);
});
