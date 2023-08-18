import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/gptController.dart';
import '../controllers/userController.dart';

class SideTileSummary extends StatelessWidget {
  final title;
  final texts;
  final summary;
  SideTileSummary({
    super.key,
    required this.title,
    required this.texts,
    required this.summary,
  });
  final UserController userController = Get.put(UserController());
  final GPTController gptController = Get.put(GPTController());

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
        // textDirection: TextDirection.rtl,
      ),
      // controlAffinity: ListTileControlAffinity.leading,
      children: texts
          .map<Widget>(
            (e) => GetBuilder<UserController>(
              builder: (_) => InkWell(
                onTap: () {
                  summary.context.clear();
                  Map js = {"role": "user", "content": _.user.introText};
                  summary.context.add(js);
                  // summary.context =
                  //     "{\"role\": \"system\", \"content\": ${_.user.introText}}\n";
                  js = {"role": "user", "content": e};
                  summary.context.add(js);
                  // summary.context +=
                  //     "{\"role\": \"user\", \"content\" : \"$e\"}\n";
                  gptController.getResponseFromAPI(summary.context, summary);
                },
                child: ListTile(
                  leading: const Icon(Icons.play_arrow_rounded),
                  title: Text(
                    e,
                    // textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
