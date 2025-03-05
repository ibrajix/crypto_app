// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChartDataStateImpl _$$ChartDataStateImplFromJson(Map<String, dynamic> json) =>
    _$ChartDataStateImpl(
      candles: (json['candles'] as List<dynamic>?)
              ?.map((e) => CandleData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      symbol: json['symbol'] as String? ?? 'BTCUSDT',
      interval: json['interval'] as String? ?? '1d',
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$ChartDataStateImplToJson(
        _$ChartDataStateImpl instance) =>
    <String, dynamic>{
      'candles': instance.candles,
      'symbol': instance.symbol,
      'interval': instance.interval,
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
