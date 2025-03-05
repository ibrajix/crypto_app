// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/candle_ticker_model.dart';
import '../data/model/order_book_model.dart';
import '../data/model/symbols_model.dart';
import '../data/repository/binance_repository.dart';
import '../widgets/chart_orderbook_widget.dart';

final currentSymbolStateProvider = StateProvider<Symbols?>((ref) {
  return null;
});

final candleTickerStateProvider = StateProvider<CandleTickerModel?>((ref) {
  return null;
});

final orderBookStateProvider = StateProvider<OrderBookModel?>((ref) {
  return null;
});

final chartControllerProvider =
    NotifierProvider<ChartController, List<Candle>>(() {
  return ChartController();
});

class ChartController extends Notifier<List<Candle>> {
  @override
  List<Candle> build() {
    getCandles(StreamValue(symbol: 'BTCUSDT', interval: "1m"));
    return [];
    return [];
  }

  BinanceRepository get _binanceRepository =>
      ref.read(binanceRepositoryProvider);

  Future<List<Candle>> getCandles(StreamValue streamValue) async {
    try {
      final data = await _binanceRepository.fetchCandles(
        symbol: "BTCUSDT",
        interval: streamValue.interval,
      );

      state = data;
      return data;
    } catch (e) {
      return [];
    }
  }

  Future<void> loadMoreCandles(StreamValue streamValue) async {
    try {
      final data = await _binanceRepository.fetchCandles(
        symbol: "BTCUSDT",
        interval: streamValue.interval,
        endTime: state.last.date.millisecondsSinceEpoch,
      );

      state
        ..removeLast()
        ..addAll(data);
    } catch (e) {
      print(e);
    }
  }
}
