import 'package:freezed_annotation/freezed_annotation.dart';

part 'orderbook_entry.freezed.dart';
part 'orderbook_entry.g.dart';

@freezed
class OrderbookEntry with _$OrderbookEntry {
  const factory OrderbookEntry({
    required double price,
    required double amount,
    required double total,
    @Default(false)
    bool isBid, // true for buy orders (green), false for sell orders (red)
  }) = _OrderbookEntry;

  factory OrderbookEntry.fromJson(Map<String, dynamic> json) =>
      _$OrderbookEntryFromJson(json);
}
