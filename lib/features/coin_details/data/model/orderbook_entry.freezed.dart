// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orderbook_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderbookEntry _$OrderbookEntryFromJson(Map<String, dynamic> json) {
  return _OrderbookEntry.fromJson(json);
}

/// @nodoc
mixin _$OrderbookEntry {
  double get price => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  bool get isBid => throw _privateConstructorUsedError;

  /// Serializes this OrderbookEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderbookEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderbookEntryCopyWith<OrderbookEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderbookEntryCopyWith<$Res> {
  factory $OrderbookEntryCopyWith(
          OrderbookEntry value, $Res Function(OrderbookEntry) then) =
      _$OrderbookEntryCopyWithImpl<$Res, OrderbookEntry>;
  @useResult
  $Res call({double price, double amount, double total, bool isBid});
}

/// @nodoc
class _$OrderbookEntryCopyWithImpl<$Res, $Val extends OrderbookEntry>
    implements $OrderbookEntryCopyWith<$Res> {
  _$OrderbookEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderbookEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? amount = null,
    Object? total = null,
    Object? isBid = null,
  }) {
    return _then(_value.copyWith(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      isBid: null == isBid
          ? _value.isBid
          : isBid // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderbookEntryImplCopyWith<$Res>
    implements $OrderbookEntryCopyWith<$Res> {
  factory _$$OrderbookEntryImplCopyWith(_$OrderbookEntryImpl value,
          $Res Function(_$OrderbookEntryImpl) then) =
      __$$OrderbookEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double price, double amount, double total, bool isBid});
}

/// @nodoc
class __$$OrderbookEntryImplCopyWithImpl<$Res>
    extends _$OrderbookEntryCopyWithImpl<$Res, _$OrderbookEntryImpl>
    implements _$$OrderbookEntryImplCopyWith<$Res> {
  __$$OrderbookEntryImplCopyWithImpl(
      _$OrderbookEntryImpl _value, $Res Function(_$OrderbookEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderbookEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
    Object? amount = null,
    Object? total = null,
    Object? isBid = null,
  }) {
    return _then(_$OrderbookEntryImpl(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      isBid: null == isBid
          ? _value.isBid
          : isBid // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderbookEntryImpl implements _OrderbookEntry {
  const _$OrderbookEntryImpl(
      {required this.price,
      required this.amount,
      required this.total,
      this.isBid = false});

  factory _$OrderbookEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderbookEntryImplFromJson(json);

  @override
  final double price;
  @override
  final double amount;
  @override
  final double total;
  @override
  @JsonKey()
  final bool isBid;

  @override
  String toString() {
    return 'OrderbookEntry(price: $price, amount: $amount, total: $total, isBid: $isBid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderbookEntryImpl &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.isBid, isBid) || other.isBid == isBid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, price, amount, total, isBid);

  /// Create a copy of OrderbookEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderbookEntryImplCopyWith<_$OrderbookEntryImpl> get copyWith =>
      __$$OrderbookEntryImplCopyWithImpl<_$OrderbookEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderbookEntryImplToJson(
      this,
    );
  }
}

abstract class _OrderbookEntry implements OrderbookEntry {
  const factory _OrderbookEntry(
      {required final double price,
      required final double amount,
      required final double total,
      final bool isBid}) = _$OrderbookEntryImpl;

  factory _OrderbookEntry.fromJson(Map<String, dynamic> json) =
      _$OrderbookEntryImpl.fromJson;

  @override
  double get price;
  @override
  double get amount;
  @override
  double get total;
  @override
  bool get isBid;

  /// Create a copy of OrderbookEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderbookEntryImplCopyWith<_$OrderbookEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
