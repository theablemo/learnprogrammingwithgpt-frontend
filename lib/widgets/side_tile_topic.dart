import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introductory_programming_frontend_teacher/controllers/gptController.dart';
import 'package:introductory_programming_frontend_teacher/controllers/userController.dart';

class SideTileTopic extends StatelessWidget {
  final title;
  final explanation;
  final examples;
  final exercise;
  final topic;
  SideTileTopic({
    super.key,
    required this.title,
    required this.explanation,
    required this.examples,
    required this.exercise,
    required this.topic,
  });

  final UserController userController = Get.put(UserController());
  final GPTController gptController = Get.put(GPTController());

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        // textDirection: TextDirection.rtl,
      ),
      // controlAffinity: ListTileControlAffinity.leading,
      tilePadding: EdgeInsets.only(left: 5),

      children: [
        GetBuilder<UserController>(builder: (_) {
          return InkWell(
            onTap: () {
              topic.context.clear();
              Map js = {"role": "system", "content": _.user.introText};
              topic.context.add(js);
              // topic.context = "${_.user.introText}\n";
              js = {"role": "user", "content": explanation};
              topic.context.add(js);
              // topic.context += "$explanation\n";
              gptController.getResponseFromAPI(topic.context, topic);
            },
            child: ListTile(
              leading: Icon(Icons.play_arrow_rounded),
              title: Text(
                'explanation'.tr,
                // textDirection: TextDirection.rtl,
              ),
              subtitle: Text(
                explanation,
                // textDirection: TextDirection.rtl,
              ),
            ),
          );
        }),
        ...examples.map((e) {
          return InkWell(
            onTap: () {
              Map js = {"role": "user", "content": e};
              topic.context.add(js);
              // topic.context += "User: $e\n";
              gptController.getResponseFromAPI(topic.context, topic);
            },
            child: ListTile(
              leading: Icon(Icons.play_arrow_rounded),
              title: Text(
                'example'.tr,
                // textDirection: TextDirection.rtl,
              ),
              subtitle: Text(
                e,
                // textDirection: TextDirection.rtl,
              ),
            ),
          );
        }).toList(),
        ...exercise.map((e) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  Map js = {"role": "user", "content": e};
                  topic.context.add(js);
                  // topic.context += "User: $e\n";
                  gptController.getResponseFromAPI(topic.context, topic);
                },
                child: ListTile(
                  leading: const Icon(Icons.play_arrow_rounded),
                  title: Text(
                    'exercise'.tr,
                    // textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    e,
                    // textDirection: TextDirection.rtl,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Map js = {
                    "role": "user",
                    "content": 'exercise_solution_prompt'.tr,
                  };
                  topic.context.add(js);
                  // topic.context += "User: $e\n";
                  gptController.getResponseFromAPI(topic.context, topic);
                },
                child: ListTile(
                  leading: const Icon(Icons.play_arrow_rounded),
                  title: Text(
                    'exercise_solution'.tr,
                    // textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    'exercise_solution_prompt'.tr,
                    // textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
