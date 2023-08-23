import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class GPTController extends GetxController {
  bool loading = false;
  String gptAnswer = 'choose_lesson'.tr;

  void setLoading(bool value) {
    loading = value;
    update();
  }

  void setGPTAnswer(String value) {
    gptAnswer = value;
    update();
  }

  Future<void> getResponseFromAPI(List prompt, dynamic topic) async {
    setLoading(true);
    final apiUrl =
        'https://back.learnprogrammingwithgpt.com/prompt'; // Replace with your Flask app URL
    // 'http://127.0.0.1:5000/prompt';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'prompt': prompt}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final answer = responseData['answer'];
        setGPTAnswer(answer);
        topic.context.add({"role": "assistant", "content": answer});
        // topic.context +=
        //     "{\"role\": \"assistant\", \"content\" : \"${answer}\"}\n";
      } else {
        setGPTAnswer('Error: ${jsonDecode(response.body)['error']}');
      }
    } catch (e) {
      setGPTAnswer('Error: $e');
    }
    setLoading(false);
  }
}
