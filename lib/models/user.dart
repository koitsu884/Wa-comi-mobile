import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String name;
  final String introduction;
  final String avatar;
  final String twitter;
  final String facebook;
  final String instagram;
  final bool admin;

  User({
    @required this.id,
    this.email,
    @required this.name,
    this.introduction,
    this.avatar,
    this.twitter,
    this.facebook,
    this.instagram,
    this.admin = false,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
