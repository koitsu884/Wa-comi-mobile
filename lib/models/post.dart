import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final int user_id;
  final String title;
  final String content;
  final String image;
  final int comment_count;

  Post({
    this.id,
    this.user_id,
    @required this.title,
    @required this.content,
    this.image,
    this.comment_count,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
