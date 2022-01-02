// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfo _$$_UserInfoFromJson(Map<String, dynamic> json) => _$_UserInfo(
      json['email'] as String?,
      json['uid'] as String?,
      json['firstName'] as String,
      json['surname'] as String,
      json['photoURL'] as String?,
      (json['joinedCourses'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'photoURL': instance.photoURL,
      'joinedCourses': instance.joinedCourses,
    };
