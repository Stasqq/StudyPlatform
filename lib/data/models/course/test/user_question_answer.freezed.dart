// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_question_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserQuestionAnswer _$UserQuestionAnswerFromJson(Map<String, dynamic> json) {
  return _UserQuestionAnswer.fromJson(json);
}

/// @nodoc
class _$UserQuestionAnswerTearOff {
  const _$UserQuestionAnswerTearOff();

  _UserQuestionAnswer call(List<Answer> answers, List<bool> checked) {
    return _UserQuestionAnswer(
      answers,
      checked,
    );
  }

  UserQuestionAnswer fromJson(Map<String, Object?> json) {
    return UserQuestionAnswer.fromJson(json);
  }
}

/// @nodoc
const $UserQuestionAnswer = _$UserQuestionAnswerTearOff();

/// @nodoc
mixin _$UserQuestionAnswer {
  List<Answer> get answers => throw _privateConstructorUsedError;
  List<bool> get checked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserQuestionAnswerCopyWith<UserQuestionAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserQuestionAnswerCopyWith<$Res> {
  factory $UserQuestionAnswerCopyWith(
          UserQuestionAnswer value, $Res Function(UserQuestionAnswer) then) =
      _$UserQuestionAnswerCopyWithImpl<$Res>;
  $Res call({List<Answer> answers, List<bool> checked});
}

/// @nodoc
class _$UserQuestionAnswerCopyWithImpl<$Res>
    implements $UserQuestionAnswerCopyWith<$Res> {
  _$UserQuestionAnswerCopyWithImpl(this._value, this._then);

  final UserQuestionAnswer _value;
  // ignore: unused_field
  final $Res Function(UserQuestionAnswer) _then;

  @override
  $Res call({
    Object? answers = freezed,
    Object? checked = freezed,
  }) {
    return _then(_value.copyWith(
      answers: answers == freezed
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
      checked: checked == freezed
          ? _value.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc
abstract class _$UserQuestionAnswerCopyWith<$Res>
    implements $UserQuestionAnswerCopyWith<$Res> {
  factory _$UserQuestionAnswerCopyWith(
          _UserQuestionAnswer value, $Res Function(_UserQuestionAnswer) then) =
      __$UserQuestionAnswerCopyWithImpl<$Res>;
  @override
  $Res call({List<Answer> answers, List<bool> checked});
}

/// @nodoc
class __$UserQuestionAnswerCopyWithImpl<$Res>
    extends _$UserQuestionAnswerCopyWithImpl<$Res>
    implements _$UserQuestionAnswerCopyWith<$Res> {
  __$UserQuestionAnswerCopyWithImpl(
      _UserQuestionAnswer _value, $Res Function(_UserQuestionAnswer) _then)
      : super(_value, (v) => _then(v as _UserQuestionAnswer));

  @override
  _UserQuestionAnswer get _value => super._value as _UserQuestionAnswer;

  @override
  $Res call({
    Object? answers = freezed,
    Object? checked = freezed,
  }) {
    return _then(_UserQuestionAnswer(
      answers == freezed
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
      checked == freezed
          ? _value.checked
          : checked // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserQuestionAnswer implements _UserQuestionAnswer {
  const _$_UserQuestionAnswer(this.answers, this.checked);

  factory _$_UserQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$$_UserQuestionAnswerFromJson(json);

  @override
  final List<Answer> answers;
  @override
  final List<bool> checked;

  @override
  String toString() {
    return 'UserQuestionAnswer(answers: $answers, checked: $checked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserQuestionAnswer &&
            const DeepCollectionEquality().equals(other.answers, answers) &&
            const DeepCollectionEquality().equals(other.checked, checked));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(answers),
      const DeepCollectionEquality().hash(checked));

  @JsonKey(ignore: true)
  @override
  _$UserQuestionAnswerCopyWith<_UserQuestionAnswer> get copyWith =>
      __$UserQuestionAnswerCopyWithImpl<_UserQuestionAnswer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserQuestionAnswerToJson(this);
  }
}

abstract class _UserQuestionAnswer implements UserQuestionAnswer {
  const factory _UserQuestionAnswer(List<Answer> answers, List<bool> checked) =
      _$_UserQuestionAnswer;

  factory _UserQuestionAnswer.fromJson(Map<String, dynamic> json) =
      _$_UserQuestionAnswer.fromJson;

  @override
  List<Answer> get answers;
  @override
  List<bool> get checked;
  @override
  @JsonKey(ignore: true)
  _$UserQuestionAnswerCopyWith<_UserQuestionAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}
