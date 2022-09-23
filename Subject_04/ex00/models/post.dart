import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:subject/models/comment.dart';

class Post extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;
  final List<Comment> comments;
  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.comments,
  });

  @override
  List<Object> get props => [userId, id, title, body, comments];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
      'comments': comments,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    List<Comment> comments = [];
    if (map['comments'] != null) {
      for (var comment in (map['comments'] as List<dynamic>)) {
        comments.add(Comment.fromMap(comment));
      }
    }
    return Post(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      comments: comments,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
