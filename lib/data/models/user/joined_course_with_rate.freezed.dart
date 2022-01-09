// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'joined_course_with_rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JoinedCourseWithRate _$JoinedCourseWithRateFromJson(Map<String, dynamic> json) {
  return _JoinedCourseWithRate.fromJson(json);
}

/// @nodoc
class _$JoinedCourseWithRateTearOff {
  const _$JoinedCourseWithRateTearOff();

  _JoinedCourseWithRate call(String courseId, int rate) {
    return _JoinedCourseWithRate(
      courseId,
      rate,
    );
  }

  JoinedCourseWithRate fromJson(Map<String, Object?> json) {
    return JoinedCourseWithRate.fromJson(json);
  }
}

/// @nodoc
const $JoinedCourseWithRate = _$JoinedCourseWithRateTearOff();

/// @nodoc
mixin _$JoinedCourseWithRate {
  String get courseId => throw _privateConstructorUsedError;
  int get rate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinedCourseWithRateCopyWith<JoinedCourseWithRate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinedCourseWithRateCopyWith<$Res> {
  factory $JoinedCourseWithRateCopyWith(JoinedCourseWithRate value,
          $Res Function(JoinedCourseWithRate) then) =
      _$JoinedCourseWithRateCopyWithImpl<$Res>;
  $Res call({String courseId, int rate});
}

/// @nodoc
class _$JoinedCourseWithRateCopyWithImpl<$Res>
    implements $JoinedCourseWithRateCopyWith<$Res> {
  _$JoinedCourseWithRateCopyWithImpl(this._value, this._then);

  final JoinedCourseWithRate _value;
  // ignore: unused_field
  final $Res Function(JoinedCourseWithRate) _then;

  @override
  $Res call({
    Object? courseId = freezed,
    Object? rate = freezed,
  }) {
    return _then(_value.copyWith(
      courseId: courseId == freezed
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      rate: rate == freezed
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$JoinedCourseWithRateCopyWith<$Res>
    implements $JoinedCourseWithRateCopyWith<$Res> {
  factory _$JoinedCourseWithRateCopyWith(_JoinedCourseWithRate value,
          $Res Function(_JoinedCourseWithRate) then) =
      __$JoinedCourseWithRateCopyWithImpl<$Res>;
  @override
  $Res call({String courseId, int rate});
}

/// @nodoc
class __$JoinedCourseWithRateCopyWithImpl<$Res>
    extends _$JoinedCourseWithRateCopyWithImpl<$Res>
    implements _$JoinedCourseWithRateCopyWith<$Res> {
  __$JoinedCourseWithRateCopyWithImpl(
      _JoinedCourseWithRate _value, $Res Function(_JoinedCourseWithRate) _then)
      : super(_value, (v) => _then(v as _JoinedCourseWithRate));

  @override
  _JoinedCourseWithRate get _value => super._value as _JoinedCourseWithRate;

  @override
  $Res call({
    Object? courseId = freezed,
    Object? rate = freezed,
  }) {
    return _then(_JoinedCourseWithRate(
      courseId == freezed
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      rate == freezed
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JoinedCourseWithRate implements _JoinedCourseWithRate {
  const _$_JoinedCourseWithRate(this.courseId, this.rate);

  factory _$_JoinedCourseWithRate.fromJson(Map<String, dynamic> json) =>
      _$$_JoinedCourseWithRateFromJson(json);

  @override
  final String courseId;
  @override
  final int rate;

  @override
  String toString() {
    return 'JoinedCourseWithRate(courseId: $courseId, rate: $rate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JoinedCourseWithRate &&
            const DeepCollectionEquality().equals(other.courseId, courseId) &&
            const DeepCollectionEquality().equals(other.rate, rate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(courseId),
      const DeepCollectionEquality().hash(rate));

  @JsonKey(ignore: true)
  @override
  _$JoinedCourseWithRateCopyWith<_JoinedCourseWithRate> get copyWith =>
      __$JoinedCourseWithRateCopyWithImpl<_JoinedCourseWithRate>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JoinedCourseWithRateToJson(this);
  }
}

abstract class _JoinedCourseWithRate implements JoinedCourseWithRate {
  const factory _JoinedCourseWithRate(String courseId, int rate) =
      _$_JoinedCourseWithRate;

  factory _JoinedCourseWithRate.fromJson(Map<String, dynamic> json) =
      _$_JoinedCourseWithRate.fromJson;

  @override
  String get courseId;
  @override
  int get rate;
  @override
  @JsonKey(ignore: true)
  _$JoinedCourseWithRateCopyWith<_JoinedCourseWithRate> get copyWith =>
      throw _privateConstructorUsedError;
}
