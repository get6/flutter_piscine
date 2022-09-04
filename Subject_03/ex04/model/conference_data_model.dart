import 'dart:convert';

class ConferenceDataModel {
  final String name;
  final String link;
  final DateTime start;
  final DateTime end;
  final String location;

  ConferenceDataModel({
    required this.name,
    required this.link,
    required this.start,
    required this.end,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'link': link,
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'location': location,
    };
  }

  factory ConferenceDataModel.fromMap(Map<String, dynamic> map) {
    return ConferenceDataModel(
      name: map['name'] as String,
      link: map['link'] as String,
      start: DateTime.parse(map['start'] as String),
      end: DateTime.parse(map['end'] as String),
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConferenceDataModel.fromJson(String source) =>
      ConferenceDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
