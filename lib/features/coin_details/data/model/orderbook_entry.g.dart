// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderbook_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderbookEntryImpl _$$OrderbookEntryImplFromJson(Map<String, dynamic> json) =>
    _$OrderbookEntryImpl(
      price: (json['price'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      isBid: json['isBid'] as bool? ?? false,
    );

Map<String, dynamic> _$$OrderbookEntryImplToJson(
        _$OrderbookEntryImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
      'amount': instance.amount,
      'total': instance.total,
      'isBid': instance.isBid,
    };
