import 'package:candlesticks/candlesticks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_data_model.freezed.dart';
part 'chart_data_model.g.dart';

@freezed
class ChartDataState with _$ChartDataState {
  const factory ChartDataState({
    @Default([]) List<CandleData> candles,
    @Default('BTCUSDT') String symbol,
    @Default('1d') String interval,
    @Default(false) bool isLoading,
    String? error,
  }) = _ChartDataState;

  factory ChartDataState.fromJson(Map<String, dynamic> json) =>
      _$ChartDataStateFromJson(json);
}

// Custom class to handle JSON serialization
class CandleData {
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;
  final DateTime date;

  CandleData({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.date,
  });

  // Convert Candle to CandleData
  factory CandleData.fromCandle(Candle candle) {
    return CandleData(
      open: candle.open,
      high: candle.high,
      low: candle.low,
      close: candle.close,
      volume: candle.volume,
      date: candle.date,
    );
  }

  // Convert CandleData back to Candle
  Candle toCandle() {
    return Candle(
      open: open,
      high: high,
      low: low,
      close: close,
      volume: volume,
      date: date,
    );
  }

  // JSON serialization
  factory CandleData.fromJson(Map<String, dynamic> json) => CandleData(
        open: (json['open'] as num).toDouble(),
        high: (json['high'] as num).toDouble(),
        low: (json['low'] as num).toDouble(),
        close: (json['close'] as num).toDouble(),
        volume: (json['volume'] as num).toDouble(),
        date: DateTime.parse(json['date'] as String),
      );

  Map<String, dynamic> toJson() => {
        'open': open,
        'high': high,
        'low': low,
        'close': close,
        'volume': volume,
        'date': date.toIso8601String(),
      };
}
