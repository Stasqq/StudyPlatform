// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
class _$CourseTearOff {
  const _$CourseTearOff();

  _Course call(String id, String ownerEmail, String ownerName, String name,
      String description, bool public, int summaryRate, int ratesNumber) {
    return _Course(
      id,
      ownerEmail,
      ownerName,
      name,
      description,
      public,
      summaryRate,
      ratesNumber,
    );
  }

  Course fromJson(Map<String, Object?> json) {
    return Course.fromJson(json);
  }
}

/// @nodoc
const $Course = _$CourseTearOff();

/// @nodoc
mixin _$Course {
  String get id => throw _privateConstructorUsedError;
  String get ownerEmail => throw _privateConstructorUsedError;
  String get ownerName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get public => throw _privateConstructorUsedError;
  int get summaryRate => throw _privateConstructorUsedError;
  int get ratesNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String ownerEmail,
      String ownerName,
      String name,
      String description,
      bool public,
      int summaryRate,
      int ratesNumber});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res> implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  final Course _value;
  // ignore: unused_field
  final $Res Function(Course) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? ownerEmail = freezed,
    Object? ownerName = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? public = freezed,
    Object? summaryRate = freezed,
    Object? ratesNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerEmail: ownerEmail == freezed
          ? _value.ownerEmail
          : ownerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName: ownerName == freezed
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      public: public == freezed
          ? _value.public
          : public // ignore: cast_nullable_to_non_nullable
              as bool,
      summaryRate: summaryRate == freezed
          ? _value.summaryRate
          : summaryRate // ignore: cast_nullable_to_non_nullable
              as int,
      ratesNumber: ratesNumber == freezed
          ? _value.ratesNumber
          : ratesNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$CourseCopyWith(_Course value, $Res Function(_Course) then) =
      __$CourseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String ownerEmail,
      String ownerName,
      String name,
      String description,
      bool public,
      int summaryRate,
      int ratesNumber});
}

/// @nodoc
class __$CourseCopyWithImpl<$Res> extends _$CourseCopyWithImpl<$Res>
    implements _$CourseCopyWith<$Res> {
  __$CourseCopyWithImpl(_Course _value, $Res Function(_Course) _then)
      : super(_value, (v) => _then(v as _Course));

  @override
  _Course get _value => super._value as _Course;

  @override
  $Res call({
    Object? id = freezed,
    Object? ownerEmail = freezed,
    Object? ownerName = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? public = freezed,
    Object? summaryRate = freezed,
    Object? ratesNumber = freezed,
  }) {
    return _then(_Course(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerEmail == freezed
          ? _value.ownerEmail
          : ownerEmail // ignore: cast_nullable_to_non_nullable
              as String,
      ownerName == freezed
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String,
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      public == freezed
          ? _value.public
          : public // ignore: cast_nullable_to_non_nullable
              as bool,
      summaryRate == freezed
          ? _value.summaryRate
          : summaryRate // ignore: cast_nullable_to_non_nullable
              as int,
      ratesNumber == freezed
          ? _value.ratesNumber
          : ratesNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Course extends _Course {
  const _$_Course(this.id, this.ownerEmail, this.ownerName, this.name,
      this.description, this.public, this.summaryRate, this.ratesNumber)
      : super._();

  factory _$_Course.fromJson(Map<String, dynamic> json) =>
      _$$_CourseFromJson(json);

  @override
  final String id;
  @override
  final String ownerEmail;
  @override
  final String ownerName;
  @override
  final String name;
  @override
  final String description;
  @override
  final bool public;
  @override
  final int summaryRate;
  @override
  final int ratesNumber;

  @override
  String toString() {
    return 'Course(id: $id, ownerEmail: $ownerEmail, ownerName: $ownerName, name: $name, description: $description, public: $public, summaryRate: $summaryRate, ratesNumber: $ratesNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Course &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.ownerEmail, ownerEmail) &&
            const DeepCollectionEquality().equals(other.ownerName, ownerName) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.public, public) &&
            const DeepCollectionEquality()
                .equals(other.summaryRate, summaryRate) &&
            const DeepCollectionEquality()
                .equals(other.ratesNumber, ratesNumber));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(ownerEmail),
      const DeepCollectionEquality().hash(ownerName),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(public),
      const DeepCollectionEquality().hash(summaryRate),
      const DeepCollectionEquality().hash(ratesNumber));

  @JsonKey(ignore: true)
  @override
  _$CourseCopyWith<_Course> get copyWith =>
      __$CourseCopyWithImpl<_Course>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourseToJson(this);
  }
}

abstract class _Course extends Course {
  const factory _Course(
      String id,
      String ownerEmail,
      String ownerName,
      String name,
      String description,
      bool public,
      int summaryRate,
      int ratesNumber) = _$_Course;
  const _Course._() : super._();

  factory _Course.fromJson(Map<String, dynamic> json) = _$_Course.fromJson;

  @override
  String get id;
  @override
  String get ownerEmail;
  @override
  String get ownerName;
  @override
  String get name;
  @override
  String get description;
  @override
  bool get public;
  @override
  int get summaryRate;
  @override
  int get ratesNumber;
  @override
  @JsonKey(ignore: true)
  _$CourseCopyWith<_Course> get copyWith => throw _privateConstructorUsedError;
}
