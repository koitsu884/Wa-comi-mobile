// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as int,
    user_id: json['user_id'] as int,
    title: json['title'] as String,
    content: json['content'] as String,
    image: json['image'] as String,
    comment_count: json['comment_count'] as int,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'user_id': instance.user_id,
    'title': instance.title,
    'content': instance.content,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image', instance.image);
  val['comment_count'] = instance.comment_count;
  return val;
}
