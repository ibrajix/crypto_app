// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChartDataState _$ChartDataStateFromJson(Map<String, dynamic> json) {
  return _ChartDataState.fromJson(json);
}

/// @nodoc
mixin _$ChartDataState {
  List<CandleData> get candles => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get interval => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this ChartDataState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartDataStateCopyWith<ChartDataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartDataStateCopyWith<$Res> {
  factory $ChartDataStateCopyWith(
          ChartDataState value, $Res Function(ChartDataState) then) =
      _$ChartDataStateCopyWithImpl<$Res, ChartDataState>;
  @useResult
  $Res call(
      {List<CandleData> candles,
      String symbol,
      String interval,
      bool isLoading,
      String? error});
}

/// @nodoc
class _$ChartDataStateCopyWithImpl<$Res, $Val extends ChartDataState>
    implements $ChartDataStateCopyWith<$Res> {
  _$ChartDataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candles = null,
    Object? symbol = null,
    Object? interval = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      candles: null == candles
          ? _value.candles
          : candles // ignore: cast_nullable_to_non_nullable
              as List<CandleData>,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartDataStateImplCopyWith<$Res>
    implements $ChartDataStateCopyWith<$Res> {
  factory _$$ChartDataStateImplCopyWith(_$ChartDataStateImpl value,
          $Res Function(_$ChartDataStateImpl) then) =
      __$$ChartDataStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CandleData> candles,
      String symbol,
      String interval,
      bool isLoading,
      String? error});
}

/// @nodoc
class __$$ChartDataStateImplCopyWithImpl<$Res>
    extends _$ChartDataStateCopyWithImpl<$Res, _$ChartDataStateImpl>
    implements _$$ChartDataStateImplCopyWith<$Res> {
  __$$ChartDataStateImplCopyWithImpl(
      _$ChartDataStateImpl _value, $Res Function(_$ChartDataStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? candles = null,
    Object? symbol = null,
    Object? interval = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$ChartDataStateImpl(
      candles: null == candles
          ? _value._candles
          : candles // ignore: cast_nullable_to_non_nullable
              as List<CandleData>,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChartDataStateImpl implements _ChartDataState {
  const _$ChartDataStateImpl(
      {final List<CandleData> candles = const [],
      this.symbol = 'BTCUSDT',
      this.interval = '1d',
      this.isLoading = false,
      this.error})
      : _candles = candles;

  factory _$ChartDataStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChartDataStateImplFromJson(json);

  final List<CandleData> _candles;
  @override
  @JsonKey()
  List<CandleData> get candles {
    if (_candles is EqualUnmodifiableListView) return _candles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_candles);
  }

  @override
  @JsonKey()
  final String symbol;
  @override
  @JsonKey()
  final String interval;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'ChartDataState(candles: $candles, symbol: $symbol, interval: $interval, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartDataStateImpl &&
            const DeepCollectionEquality().equals(other._candles, _candles) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_candles),
      symbol,
      interval,
      isLoading,
      error);

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartDataStateImplCopyWith<_$ChartDataStateImpl> get copyWith =>
      __$$ChartDataStateImplCopyWithImpl<_$ChartDataStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChartDataStateImplToJson(
      this,
    );
  }
}

abstract class _ChartDataState implements ChartDataState {
  const factory _ChartDataState(
      {final List<CandleData> candles,
      final String symbol,
      final String interval,
      final bool isLoading,
      final String? error}) = _$ChartDataStateImpl;

  factory _ChartDataState.fromJson(Map<String, dynamic> json) =
      _$ChartDataStateImpl.fromJson;

  @override
  List<CandleData> get candles;
  @override
  String get symbol;
  @override
  String get interval;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of ChartDataState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartDataStateImplCopyWith<_$ChartDataStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
