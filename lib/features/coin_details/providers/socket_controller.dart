// // ignore_for_file: invalid_use_of_protected_member
//
// import 'dart:convert';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../data/model/candle_ticker_model.dart';
// import '../data/model/order_book_model.dart';
// import '../data/repository/binance_repository.dart';
// import '../widgets/chart_orderbook_widget.dart';
// import 'chart_controller.dart';
//
// final socketController = StreamProvider.family<CandleTickerModel, StreamValue?>(
//     (ref, streamValue) async* {
//   final binanceRepository = ref.read(binanceRepositoryProvider);
//
//   final channel = binanceRepository.establishConnection(
//     "BTCUSDT",
//     '1m',
//   );
//   print("Socket connection established");
//
//   ref.onDispose(
//     () {
//       channel.sink.close();
//     },
//   );
//
//   await for (final String value in channel.stream) {
//     final map = jsonDecode(value) as Map<String, dynamic>;
//     print("Received WebSocket message: $map");
//
//     final candles = ref.read(chartControllerProvider);
//
//     final eventType = map['e'];
//
//     print("Event type: $eventType");
//
//     if (eventType == 'kline') {
//       final candleTicker = CandleTickerModel.fromJson(map);
//
//       ref.read(candleTickerStateProvider.notifier).state = candleTicker;
//
//       if (candles[0].date == candleTicker.candle.date &&
//           candles[0].open == candleTicker.candle.open) {
//         candles[0] = candleTicker.candle;
//       } else if (candleTicker.candle.date.difference(candles[0].date) ==
//           candles[0].date.difference(candles[1].date)) {
//         ref
//             .read(chartControllerProvider.notifier)
//             .state
//             .insert(0, candleTicker.candle);
//       }
//     } else if (eventType == 'depthUpdate') {
//       print("Depth update received");
//       final orderBook = OrderBookModel.fromJson(map);
//       print("Parsed OrderBook: ${orderBook.asks}, ${orderBook.bids}");
//       ref.read(orderBookStateProvider.notifier).state = orderBook;
//     }
//   }
// });
