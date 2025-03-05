// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebSocketState {
  dynamic get candlestickData => throw _privateConstructorUsedError;
  dynamic get orderbookData => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSocketStateCopyWith<WebSocketState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketStateCopyWith<$Res> {
  factory $WebSocketStateCopyWith(
          WebSocketState value, $Res Function(WebSocketState) then) =
      _$WebSocketStateCopyWithImpl<$Res, WebSocketState>;
  @useResult
  $Res call({dynamic candlestickData, dynamic orderbookData, bool isConnected});
}

/// @nodoc
class _$WebSocketStateCopyWithImpl<$Res, $Val extends WebSocketState>
    implements $WebSocketStateCopyWith<$Res> {
  _$WebSocketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candlestickData = freezed,
    Object? orderbookData = freezed,
    Object? isConnected = null,
  }) {
    return _then(_value.copyWith(
      candlestickData: freezed == candlestickData
          ? _value.candlestickData
          : candlestickData // ignore: cast_nullable_to_non_nullable
              as dynamic,
      orderbookData: freezed == orderbookData
          ? _value.orderbookData
          : orderbookData // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebSocketStateImplCopyWith<$Res>
    implements $WebSocketStateCopyWith<$Res> {
  factory _$$WebSocketStateImplCopyWith(_$WebSocketStateImpl value,
          $Res Function(_$WebSocketStateImpl) then) =
      __$$WebSocketStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic candlestickData, dynamic orderbookData, bool isConnected});
}

/// @nodoc
class __$$WebSocketStateImplCopyWithImpl<$Res>
    extends _$WebSocketStateCopyWithImpl<$Res, _$WebSocketStateImpl>
    implements _$$WebSocketStateImplCopyWith<$Res> {
  __$$WebSocketStateImplCopyWithImpl(
      _$WebSocketStateImpl _value, $Res Function(_$WebSocketStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candlestickData = freezed,
    Object? orderbookData = freezed,
    Object? isConnected = null,
  }) {
    return _then(_$WebSocketStateImpl(
      candlestickData: freezed == candlestickData
          ? _value.candlestickData
          : candlestickData // ignore: cast_nullable_to_non_nullable
              as dynamic,
      orderbookData: freezed == orderbookData
          ? _value.orderbookData
          : orderbookData // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$WebSocketStateImpl implements _WebSocketState {
  _$WebSocketStateImpl(
      {this.candlestickData = null,
      this.orderbookData = null,
      this.isConnected = false});

  @override
  @JsonKey()
  final dynamic candlestickData;
  @override
  @JsonKey()
  final dynamic orderbookData;
  @override
  @JsonKey()
  final bool isConnected;

  @override
  String toString() {
    return 'WebSocketState(candlestickData: $candlestickData, orderbookData: $orderbookData, isConnected: $isConnected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketStateImpl &&
            const DeepCollectionEquality()
                .equals(other.candlestickData, candlestickData) &&
            const DeepCollectionEquality()
                .equals(other.orderbookData, orderbookData) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(candlestickData),
      const DeepCollectionEquality().hash(orderbookData),
      isConnected);

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketStateImplCopyWith<_$WebSocketStateImpl> get copyWith =>
      __$$WebSocketStateImplCopyWithImpl<_$WebSocketStateImpl>(
          this, _$identity);
}

abstract class _WebSocketState implements WebSocketState {
  factory _WebSocketState(
      {final dynamic candlestickData,
      final dynamic orderbookData,
      final bool isConnected}) = _$WebSocketStateImpl;

  @override
  dynamic get candlestickData;
  @override
  dynamic get orderbookData;
  @override
  bool get isConnected;

  /// Create a copy of WebSocketState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketStateImplCopyWith<_$WebSocketStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
