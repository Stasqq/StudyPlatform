// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Class _$ClassFromJson(Map<String, dynamic> json) {
  return _Class.fromJson(json);
}

/// @nodoc
class _$ClassTearOff {
  const _$ClassTearOff();

  _Class call(String name, int orderIndex, String description,
      String htmlBodyPath, List<String> materials) {
    return _Class(
      name,
      orderIndex,
      description,
      htmlBodyPath,
      materials,
    );
  }

  Class fromJson(Map<String, Object?> json) {
    return Class.fromJson(json);
  }
}

/// @nodoc
const $Class = _$ClassTearOff();

/// @nodoc
mixin _$Class {
  String get name => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get htmlBodyPath => throw _privateConstructorUsedError;
  List<String> get materials => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClassCopyWith<Class> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassCopyWith<$Res> {
  factory $ClassCopyWith(Class value, $Res Function(Class) then) =
      _$ClassCopyWithImpl<$Res>;
  $Res call(
      {String name,
      int orderIndex,
      String description,
      String htmlBodyPath,
      List<String> materials});
}

/// @nodoc
class _$ClassCopyWithImpl<$Res> implements $ClassCopyWith<$Res> {
  _$ClassCopyWithImpl(this._value, this._then);

  final Class _value;
  // ignore: unused_field
  final $Res Function(Class) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? orderIndex = freezed,
    Object? description = freezed,
    Object? htmlBodyPath = freezed,
    Object? materials = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      orderIndex: orderIndex == freezed
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      htmlBodyPath: htmlBodyPath == freezed
          ? _value.htmlBodyPath
          : htmlBodyPath // ignore: cast_nullable_to_non_nullable
              as String,
      materials: materials == freezed
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$ClassCopyWith<$Res> implements $ClassCopyWith<$Res> {
  factory _$ClassCopyWith(_Class value, $Res Function(_Class) then) =
      __$ClassCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      int orderIndex,
      String description,
      String htmlBodyPath,
      List<String> materials});
}

/// @nodoc
class __$ClassCopyWithImpl<$Res> extends _$ClassCopyWithImpl<$Res>
    implements _$ClassCopyWith<$Res> {
  __$ClassCopyWithImpl(_Class _value, $Res Function(_Class) _then)
      : super(_value, (v) => _then(v as _Class));

  @override
  _Class get _value => super._value as _Class;

  @override
  $Res call({
    Object? name = freezed,
    Object? orderIndex = freezed,
    Object? description = freezed,
    Object? htmlBodyPath = freezed,
    Object? materials = freezed,
  }) {
    return _then(_Class(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      orderIndex == freezed
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int,
      description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      htmlBodyPath == freezed
          ? _value.htmlBodyPath
          : htmlBodyPath // ignore: cast_nullable_to_non_nullable
              as String,
      materials == freezed
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Class implements _Class {
  const _$_Class(this.name, this.orderIndex, this.description,
      this.htmlBodyPath, this.materials);

  factory _$_Class.fromJson(Map<String, dynamic> json) =>
      _$$_ClassFromJson(json);

  @override
  final String name;
  @override
  final int orderIndex;
  @override
  final String description;
  @override
  final String htmlBodyPath;
  @override
  final List<String> materials;

  @override
  String toString() {
    return 'Class(name: $name, orderIndex: $orderIndex, description: $description, htmlBodyPath: $htmlBodyPath, materials: $materials)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Class &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.orderIndex, orderIndex) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.htmlBodyPath, htmlBodyPath) &&
            const DeepCollectionEquality().equals(other.materials, materials));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(orderIndex),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(htmlBodyPath),
      const DeepCollectionEquality().hash(materials));

  @JsonKey(ignore: true)
  @override
  _$ClassCopyWith<_Class> get copyWith =>
      __$ClassCopyWithImpl<_Class>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClassToJson(this);
  }
}

abstract class _Class implements Class {
  const factory _Class(String name, int orderIndex, String description,
      String htmlBodyPath, List<String> materials) = _$_Class;

  factory _Class.fromJson(Map<String, dynamic> json) = _$_Class.fromJson;

  @override
  String get name;
  @override
  int get orderIndex;
  @override
  String get description;
  @override
  String get htmlBodyPath;
  @override
  List<String> get materials;
  @override
  @JsonKey(ignore: true)
  _$ClassCopyWith<_Class> get copyWith => throw _privateConstructorUsedError;
}
