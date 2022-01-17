// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfo _$$_UserInfoFromJson(Map json) => _$_UserInfo(
      json['email'] as String?,
      json['uid'] as String?,
      json['firstName'] as String,
      json['surname'] as String,
      json['photoPath'] as String?,
      (json['joinedCourses'] as List<dynamic>)
          .map((e) => JoinedCourseWithRate.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'firstName': instance.firstName,
      'surname': instance.surname,
      'photoPath': instance.photoPath,
      'joinedCourses': instance.joinedCourses.map((e) => e.toJson()).toList(),
    };
