// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    email: json['email'] as String,
    name: json['name'] as String,
    introduction: json['introduction'] as String,
    avatar: json['avatar'] as String,
    twitter: json['twitter'] as String,
    facebook: json['facebook'] as String,
    instagram: json['instagram'] as String,
    admin: json['admin'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'introduction': instance.introduction,
      'avatar': instance.avatar,
      'twitter': instance.twitter,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'admin': instance.admin,
    };
