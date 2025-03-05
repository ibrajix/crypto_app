import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../model/orderbook_entry.dart';

final binanceRepositoryProvider =
    Provider<BinanceRepository>((ref) => BinanceRepository());

class BinanceRepository {
  final _orderbookSubject = BehaviorSubject<List<OrderbookEntry>>.seeded([]);
  Stream<List<OrderbookEntry>> get orderbookStream => _orderbookSubject.stream;

  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    final uri = Uri.parse(
      'https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? '&endTime=$endTime' : ''}',
    );
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  WebSocketChannel establishOrderbookConnection(String symbol) {
    final lowercaseSymbol = symbol.toLowerCase();

    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/${lowercaseSymbol}@depth'),
    );

    channel.stream.listen(
      (message) {
        try {
          final parsedMessage = jsonDecode(message);

          // Extract bids and asks from the depth update
          final List<dynamic> bids = parsedMessage['b'] ?? [];
          final List<dynamic> asks = parsedMessage['a'] ?? [];

          // Convert bids and asks to OrderbookEntry
          final List<OrderbookEntry> orderbookEntries = [
            ...bids.map((bid) => OrderbookEntry(
                  price: double.parse(bid[0]),
                  amount: double.parse(bid[1]),
                  total: double.parse(bid[0]) * double.parse(bid[1]),
                  isBid: true,
                )),
            ...asks.map((ask) => OrderbookEntry(
                  price: double.parse(ask[0]),
                  amount: double.parse(ask[1]),
                  total: double.parse(ask[0]) * double.parse(ask[1]),
                  isBid: false,
                )),
          ];

          // Sort entries
          orderbookEntries.sort((a, b) => b.price.compareTo(a.price));

          // Update the stream
          _orderbookSubject.add(orderbookEntries);
        } catch (e) {
          print("Error processing orderbook message: $e");
        }
      },
      onError: (error) {
        print("Orderbook WebSocket error: $error");
      },
      onDone: () {
        print("Orderbook WebSocket connection closed");
      },
    );

    return channel;
  }

  void dispose() {
    _orderbookSubject.close();
  }
}
