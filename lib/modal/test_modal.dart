// To parse this JSON data, do
//
//     final topics = topicsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Topics> topicsFromJson(String str) =>
    List<Topics>.from(json.decode(str).map((x) => Topics.fromJson(x)));

String topicsToJson(List<Topics> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Topics {
  Topics({
    this.topicName,
    this.concepts,
    this.isTicked = false,
  });

  String? topicName;
  List<String>? concepts;
  bool? isTicked;

  factory Topics.fromJson(Map<String, dynamic> json) => Topics(
        topicName: json["topicName"] == null ? null : json["topicName"],
        concepts: json["concepts"] == null
            ? null
            : List<String>.from(json["concepts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "topicName": topicName == null ? null : topicName,
        "concepts": concepts == null
            ? null
            : List<dynamic>.from(concepts!.map((x) => x)),
      };
}
