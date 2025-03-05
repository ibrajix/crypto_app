import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/model/chart_data_model.dart';
import '../data/repository/binance_repository.dart';

class ChartDataNotifier extends StateNotifier<ChartDataState> {
  final Ref ref;

  ChartDataNotifier(this.ref) : super(const ChartDataState()) {
    fetchInitialCandles();
  }

  Future<void> fetchInitialCandles() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = ref.read(binanceRepositoryProvider);
      final candles = await repository.fetchCandles(
        symbol: state.symbol,
        interval: _mapTimeframeToInterval(state.interval),
      );

      // Convert Candle to CandleData
      final candleData =
          candles.map((candle) => CandleData.fromCandle(candle)).toList();

      state = state.copyWith(candles: candleData, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        candles: [], // Ensure candles is always a list
      );
    }
  }

  void updateTimeframe(String newTimeframe) {
    state = state.copyWith(
      interval: newTimeframe,
      isLoading: true,
      error: null,
    );
    fetchInitialCandles();
  }

  // Helper method to map timeframe to Binance interval
  String _mapTimeframeToInterval(String timeframe) {
    switch (timeframe) {
      case '1H':
        return '1h';
      case '2H':
        return '2h';
      case '4H':
        return '4h';
      case '1D':
        return '1d';
      case '1W':
        return '1w';
      case '1M':
        return '1M';
      default:
        return '1d';
    }
  }
}

final chartDataProvider =
    StateNotifierProvider<ChartDataNotifier, ChartDataState>((ref) {
  return ChartDataNotifier(ref);
});
