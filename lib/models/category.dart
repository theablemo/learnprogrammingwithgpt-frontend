import 'package:introductory_programming_frontend_teacher/models/topic.dart';

class Categ {
  final String name;
  final List<Topic> topics;

  Categ({
    required this.name,
    required this.topics,
  });

  factory Categ.fromJson(Map<String, dynamic> json) {
    List<dynamic> topicsData = json['topics'];
    List<Topic> topicsList =
        topicsData.map((topicData) => Topic.fromJson(topicData)).toList();

    return Categ(
      name: json['name'],
      topics: topicsList,
    );
  }
}
