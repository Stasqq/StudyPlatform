// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_test_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserTestResult _$UserTestResultFromJson(Map<String, dynamic> json) {
  return _UserTestResult.fromJson(json);
}

/// @nodoc
class _$UserTestResultTearOff {
  const _$UserTestResultTearOff();

  _UserTestResult call(String userId, String userName, int result) {
    return _UserTestResult(
      userId,
      userName,
      result,
    );
  }

  UserTestResult fromJson(Map<String, Object?> json) {
    return UserTestResult.fromJson(json);
  }
}

/// @nodoc
const $UserTestResult = _$UserTestResultTearOff();

/// @nodoc
mixin _$UserTestResult {
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  int get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserTestResultCopyWith<UserTestResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserTestResultCopyWith<$Res> {
  factory $UserTestResultCopyWith(
          UserTestResult value, $Res Function(UserTestResult) then) =
      _$UserTestResultCopyWithImpl<$Res>;
  $Res call({String userId, String userName, int result});
}

/// @nodoc
class _$UserTestResultCopyWithImpl<$Res>
    implements $UserTestResultCopyWith<$Res> {
  _$UserTestResultCopyWithImpl(this._value, this._then);

  final UserTestResult _value;
  // ignore: unused_field
  final $Res Function(UserTestResult) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? userName = freezed,
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$UserTestResultCopyWith<$Res>
    implements $UserTestResultCopyWith<$Res> {
  factory _$UserTestResultCopyWith(
          _UserTestResult value, $Res Function(_UserTestResult) then) =
      __$UserTestResultCopyWithImpl<$Res>;
  @override
  $Res call({String userId, String userName, int result});
}

/// @nodoc
class __$UserTestResultCopyWithImpl<$Res>
    extends _$UserTestResultCopyWithImpl<$Res>
    implements _$UserTestResultCopyWith<$Res> {
  __$UserTestResultCopyWithImpl(
      _UserTestResult _value, $Res Function(_UserTestResult) _then)
      : super(_value, (v) => _then(v as _UserTestResult));

  @override
  _UserTestResult get _value => super._value as _UserTestResult;

  @override
  $Res call({
    Object? userId = freezed,
    Object? userName = freezed,
    Object? result = freezed,
  }) {
    return _then(_UserTestResult(
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserTestResult implements _UserTestResult {
  const _$_UserTestResult(this.userId, this.userName, this.result);

  factory _$_UserTestResult.fromJson(Map<String, dynamic> json) =>
      _$$_UserTestResultFromJson(json);

  @override
  final String userId;
  @override
  final String userName;
  @override
  final int result;

  @override
  String toString() {
    return 'UserTestResult(userId: $userId, userName: $userName, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserTestResult &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  _$UserTestResultCopyWith<_UserTestResult> get copyWith =>
      __$UserTestResultCopyWithImpl<_UserTestResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserTestResultToJson(this);
  }
}

abstract class _UserTestResult implements UserTestResult {
  const factory _UserTestResult(String userId, String userName, int result) =
      _$_UserTestResult;

  factory _UserTestResult.fromJson(Map<String, dynamic> json) =
      _$_UserTestResult.fromJson;

  @override
  String get userId;
  @override
  String get userName;
  @override
  int get result;
  @override
  @JsonKey(ignore: true)
  _$UserTestResultCopyWith<_UserTestResult> get copyWith =>
      throw _privateConstructorUsedError;
}
