import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../data/model/orderbook_entry.dart';
import '../data/repository/binance_repository.dart';

final orderbookProvider =
    StateNotifierProvider<OrderbookNotifier, List<OrderbookEntry>>((ref) {
  final repository = ref.watch(binanceRepositoryProvider);
  return OrderbookNotifier(repository);
});

class OrderbookNotifier extends StateNotifier<List<OrderbookEntry>> {
  final BinanceRepository _repository;
  WebSocketChannel? _channel;

  OrderbookNotifier(this._repository) : super([]) {
    connectToOrderbook('BTCUSDT');
  }

  void connectToOrderbook(String symbol) {
    // Close existing connection if any
    _channel?.sink.close();

    // Establish new connection
    _channel = _repository.establishOrderbookConnection(symbol);

    // Listen to orderbook stream
    _repository.orderbookStream.listen((entries) {
      state = entries;
    });
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _repository.dispose();
    super.dispose();
  }
}
