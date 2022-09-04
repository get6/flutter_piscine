import 'dart:convert';

class TodoModel {
  final String title;
  final int userId;
  final int id;
  final bool completed;

  TodoModel({
    required this.title,
    required this.userId,
    required this.id,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'userId': userId,
      'id': id,
      'completed': completed,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'] as String,
      userId: map['userId'] as int,
      id: map['id'] as int,
      completed: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
