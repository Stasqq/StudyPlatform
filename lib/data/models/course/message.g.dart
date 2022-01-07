// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      json['text'] as String,
      json['senderEmail'] as String,
      json['senderName'] as String,
      json['timestamp'] as int,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'text': instance.text,
      'senderEmail': instance.senderEmail,
      'senderName': instance.senderName,
      'timestamp': instance.timestamp,
    };
