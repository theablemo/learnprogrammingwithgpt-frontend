import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:introductory_programming_frontend_teacher/controllers/mainController.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:introductory_programming_frontend_teacher/config.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'mainpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id = "";
  bool id_bad = false;
  bool waiting = false;
  final MainController mainController = Get.put(MainController());

  Future<dynamic> fetchData(String id) async {
    String url =
        '${AppConfig.apiBaseUrl}/login?id=$id&lang=${mainController.locale == LocaleEnum.EN ? 'en' : 'fa'}';
    final response = await http.get(Uri.parse(url));
    dynamic responseData;

    if (response.statusCode == 200) {
      setState(() {
        responseData = json.decode(response.body);
        id_bad = false;
      });
    } else {
      setState(() {
        responseData = "Error: ${response.statusCode}";
        id_bad = true;
      });
    }
    setState(() {
      waiting = false;
    });
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'greeting'.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'enter_code'.tr,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'example_id'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 11,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              // margin: EdgeInsets.symmetric(horizontal: 100),
              width: 400,
              child: FormBuilderTextField(
                name: 'id',
                // textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'id'.tr,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                ),
                onChanged: (val) {
                  id = val!;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (id_bad)
              Text(
                'wrong_id'.tr,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),
              ),
            waiting
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        waiting = true;
                      });
                      fetchData(id).then((value) {
                        if (!(value as String).startsWith("Error")) {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: MainPage(responseData: value, id: id),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      'accept'.tr,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "choose_language".tr,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Container(
            //   width: 600,
            //   child: Divider(
            //     color: Colors.grey,
            //   ),
            // ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: GetBuilder<MainController>(
                builder: (_) => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        _.setLocale(LocaleEnum.EN);
                        Get.updateLocale(const Locale('en', 'US'));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _.locale == LocaleEnum.EN
                              ? Colors.amber
                              : const Color.fromRGBO(0, 0, 0, 0),
                          border: Border.all(
                            color: Colors.amber,
                            width: 3,
                          ),
                        ),
                        width: 80,
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text(
                          "En",
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _.setLocale(LocaleEnum.FA);
                        Get.updateLocale(const Locale('fa', 'IR'));
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 80,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: _.locale == LocaleEnum.FA
                              ? Colors.amber
                              : Color.fromRGBO(0, 0, 0, 0),
                          border: Border.all(
                            color: Colors.amber,
                            width: 3,
                          ),
                        ),
                        child: const Text(
                          "فا",
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            icon: const Icon(
              Icons.info_outline,
              // color: Colors.grey,
            ),
            onPressed: () {
              Get.defaultDialog(
                title: 'about'.tr,
                titleStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                content: SizedBox(
                  width: 300,
                  child: Text(
                    'about_content'.tr,
                    textAlign: TextAlign.center,
                  ),
                ),
                textCancel: 'cool'.tr,
                radius: 5,
                titlePadding: const EdgeInsets.all(20),
                contentPadding: const EdgeInsets.all(
                  20,
                ),
              );
            },
            splashRadius: 20,
          ),
        ),
      ],
    );
  }
}
