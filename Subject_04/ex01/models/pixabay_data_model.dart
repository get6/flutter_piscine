import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file:
class PixabayDataModel extends Equatable {
  final int id;
  final String pageURL;
  final String previewURL;
  final int previewWidth;
  final int previewHeight;
  final String tags;
  const PixabayDataModel({
    required this.id,
    required this.pageURL,
    required this.previewURL,
    required this.previewWidth,
    required this.previewHeight,
    required this.tags,
  });

  @override
  List<Object> get props {
    return [
      id,
      pageURL,
      previewURL,
      previewWidth,
      previewHeight,
      tags,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pageURL': pageURL,
      'previewURL': previewURL,
      'previewWidth': previewWidth,
      'previewHeight': previewHeight,
      'tags': tags,
    };
  }

  factory PixabayDataModel.fromMap(Map<String, dynamic> map) {
    return PixabayDataModel(
      id: map['id'] as int,
      pageURL: map['pageURL'] as String,
      previewURL: map['previewURL'] as String,
      previewWidth: map['previewWidth'] as int,
      previewHeight: map['previewHeight'] as int,
      tags: map['tags'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PixabayDataModel.fromJson(String source) =>
      PixabayDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
