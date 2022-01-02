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

  _Course call(String id, String ownerUid, String name, String description,
      List<Class> classes, bool public) {
    return _Course(
      id,
      ownerUid,
      name,
      description,
      classes,
      public,
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
  String get ownerUid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<Class> get classes => throw _privateConstructorUsedError;
  bool get public => throw _privateConstructorUsedError;

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
      String ownerUid,
      String name,
      String description,
      List<Class> classes,
      bool public});
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
    Object? ownerUid = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? classes = freezed,
    Object? public = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUid: ownerUid == freezed
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      classes: classes == freezed
          ? _value.classes
          : classes // ignore: cast_nullable_to_non_nullable
              as List<Class>,
      public: public == freezed
          ? _value.public
          : public // ignore: cast_nullable_to_non_nullable
              as bool,
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
      String ownerUid,
      String name,
      String description,
      List<Class> classes,
      bool public});
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
    Object? ownerUid = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? classes = freezed,
    Object? public = freezed,
  }) {
    return _then(_Course(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerUid == freezed
          ? _value.ownerUid
          : ownerUid // ignore: cast_nullable_to_non_nullable
              as String,
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      classes == freezed
          ? _value.classes
          : classes // ignore: cast_nullable_to_non_nullable
              as List<Class>,
      public == freezed
          ? _value.public
          : public // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Course implements _Course {
  const _$_Course(this.id, this.ownerUid, this.name, this.description,
      this.classes, this.public);

  factory _$_Course.fromJson(Map<String, dynamic> json) =>
      _$$_CourseFromJson(json);

  @override
  final String id;
  @override
  final String ownerUid;
  @override
  final String name;
  @override
  final String description;
  @override
  final List<Class> classes;
  @override
  final bool public;

  @override
  String toString() {
    return 'Course(id: $id, ownerUid: $ownerUid, name: $name, description: $description, classes: $classes, public: $public)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Course &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.ownerUid, ownerUid) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.classes, classes) &&
            const DeepCollectionEquality().equals(other.public, public));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(ownerUid),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(classes),
      const DeepCollectionEquality().hash(public));

  @JsonKey(ignore: true)
  @override
  _$CourseCopyWith<_Course> get copyWith =>
      __$CourseCopyWithImpl<_Course>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CourseToJson(this);
  }
}

abstract class _Course implements Course {
  const factory _Course(String id, String ownerUid, String name,
      String description, List<Class> classes, bool public) = _$_Course;

  factory _Course.fromJson(Map<String, dynamic> json) = _$_Course.fromJson;

  @override
  String get id;
  @override
  String get ownerUid;
  @override
  String get name;
  @override
  String get description;
  @override
  List<Class> get classes;
  @override
  bool get public;
  @override
  @JsonKey(ignore: true)
  _$CourseCopyWith<_Course> get copyWith => throw _privateConstructorUsedError;
}
