// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoodModel _$$_MoodModelFromJson(Map<String, dynamic> json) => _$_MoodModel(
      id: json['id'] as String,
      text: json['text'] as String,
      likes: json['likes'] as int,
      replies: json['replies'] as int,
      emojiIndex: json['emojiIndex'] as int,
      creatorUid: json['creatorUid'] as String,
      created: json['created'] as int,
    );

Map<String, dynamic> _$$_MoodModelToJson(_$_MoodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'likes': instance.likes,
      'replies': instance.replies,
      'emojiIndex': instance.emojiIndex,
      'creatorUid': instance.creatorUid,
      'created': instance.created,
    };
