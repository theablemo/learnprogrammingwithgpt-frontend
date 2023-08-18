import 'package:flutter/material.dart';
import 'package:introductory_programming_frontend_teacher/widgets/side_tile_topic.dart';

class SideTileCategory extends StatelessWidget {
  final title;
  final topics;
  const SideTileCategory({
    super.key,
    required this.title,
    required this.topics,
    // required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        // textDirection: TextDirection.rtl,
      ),
      // controlAffinity: ListTileControlAffinity.leading,
      children: topics.map<Widget>((topic) {
        return SideTileTopic(
          title: topic.name,
          explanation: topic.explanation,
          examples: topic.examples,
          exercise: topic.exercise,
          topic: topic,
        );
      }).toList(),
    );
  }
}
