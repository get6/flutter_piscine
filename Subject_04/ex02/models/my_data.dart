import 'dart:convert';

// ignore_for_file:
class MyData {
  final String banana;
  final String melon;
  final String pineapple;
  final String apple;
  MyData({
    required this.banana,
    required this.melon,
    required this.pineapple,
    required this.apple,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'banana': banana,
      'melon': melon,
      'pineapple': pineapple,
      'apple': apple,
    };
  }

  factory MyData.fromMap(Map<String, dynamic> map) {
    return MyData(
      banana: map['banana'] as String,
      melon: map['melon'] as String,
      pineapple: map['pineapple'] as String,
      apple: map['apple'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyData.fromJson(String source) =>
      MyData.fromMap(json.decode(source) as Map<String, dynamic>);
}
