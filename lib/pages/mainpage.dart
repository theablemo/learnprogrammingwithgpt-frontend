import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:introductory_programming_frontend_teacher/controllers/gptController.dart';
import 'package:introductory_programming_frontend_teacher/controllers/mainController.dart';
import 'package:introductory_programming_frontend_teacher/controllers/userController.dart';
import 'package:introductory_programming_frontend_teacher/widgets/side_tile_summary.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

import '../models/user.dart';
import '../widgets/side_tile_category.dart';
import '../models/category.dart';
import '../models/summary.dart';

class MainPage extends StatefulWidget {
  final dynamic responseData;
  final String id;
  const MainPage({
    super.key,
    required this.responseData,
    required this.id,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> highlightCodeSegmentsNew(String text) {
    List<Widget> widgets = [];
    // final codeRegex = RegExp(r'```python([\s\S]*?)```');
    final codeRegex = RegExp(r'```python([\s\S]*?)```|```([\s\S]*?)```');

    var matches = codeRegex.allMatches(text);
    int previousEnd = 0;

    for (var match in matches) {
      // Add normal text before the code segment
      if (match.start > previousEnd) {
        widgets.add(
          SelectableText(
            text.substring(previousEnd, match.start),
            // textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
          ),
        );
      }

      // Add highlighted code segment
      final codeSegment = match.group(1);
      widgets.add(
        Align(
          alignment: Alignment.center,
          child: Stack(
            children: [
              HighlightView(
                codeSegment!,
                language: 'python',
                theme: githubTheme,
                padding: EdgeInsets.all(10),
                textStyle: TextStyle(fontSize: 16),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  splashRadius: 2,
                  onPressed: () {
                    FlutterClipboard.copy(codeSegment)
                        .then((value) => print('copied'));
                  },
                  icon: const Icon(
                    Icons.copy,
                  ),
                ),
              )
            ],
          ),
        ),
      );

      previousEnd = match.end;
    }

    // Add any remaining normal text
    if (previousEnd < text.length) {
      widgets.add(
        SelectableText(
          text.substring(previousEnd),
          // textDirection: TextDirection.rtl,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 16,
            decoration: TextDecoration.none,
          ),
        ),
      );
    }

    return widgets;
  }

  late final dynamic responseDataDecoded;
  List categoriesList = [];
  final UserController userController = Get.put(UserController());
  final GPTController gptController = Get.put(GPTController());
  final MainController mainController = Get.put(MainController());
  @override
  void initState() {
    responseDataDecoded = json.decode(widget.responseData);
    final categoriesJson = responseDataDecoded['categories'];
    userController.setUser(User(
      name: responseDataDecoded['name'],
      introText: responseDataDecoded['system_message'],
      id: widget.id,
    ));

    categoriesList = categoriesJson.map((categoryJson) {
      if (categoryJson.containsKey('topics')) {
        return Categ.fromJson(categoryJson);
      } else {
        return Summ.fromJson(categoryJson);
      }
    }).toList();
    categoriesList.removeWhere((item) => item == null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 251, 234, 1),
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                width: mq.size.width >= 1000
                    ? mq.size.width * 0.23
                    : mq.size.width * 0.45,
                child: SingleChildScrollView(
                  child: Column(children: [
                    GetBuilder<UserController>(
                      builder: (_) => Text(
                        'greeting_name'.trParams(
                          {
                            'name': _.user.name,
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ...categoriesList.map((e) {
                      if (e is Categ) {
                        return GetBuilder<GPTController>(
                          builder: (_) => Shimmer.fromColors(
                            enabled: _.loading,
                            baseColor: Colors.black,
                            highlightColor:
                                _.loading ? Colors.white : Colors.black,
                            child: IgnorePointer(
                              ignoring: _.loading,
                              child: SideTileCategory(
                                title: e.name,
                                topics: e.topics,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return GetBuilder<GPTController>(
                          builder: (_) => Shimmer.fromColors(
                            enabled: _.loading,
                            baseColor: Colors.black,
                            highlightColor:
                                _.loading ? Colors.white : Colors.black,
                            child: IgnorePointer(
                                ignoring: _.loading,
                                child: SideTileSummary(
                                  title: e.name,
                                  texts: e.summaries,
                                  summary: e,
                                )),
                          ),
                        );
                      }
                    }).toList()
                  ]),
                ),
              ),
              const VerticalDivider(thickness: 2),
              SizedBox(
                width: mq.size.width >= 1000
                    ? mq.size.width * 0.72
                    : mq.size.width * 0.45,
                child: Center(
                  child: GetBuilder<GPTController>(builder: (_) {
                    if (_.loading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SpinKitThreeBounce(
                            color: Colors.amber,
                          ),
                          Text(
                            'this_may_take_a_while'.tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 11,
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...highlightCodeSegmentsNew(_.gptAnswer)
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
          mainController.locale == LocaleEnum.FA
              ? Positioned(
                  top: 10,
                  left: 10,
                  child: ElevatedButton(
                    child: Text('logout'.tr),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              : Positioned(
                  top: 10,
                  right: 10,
                  child: ElevatedButton(
                    child: Text('logout'.tr),
                    onPressed: () {
                      // print(responseData);
                      Navigator.pop(context);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
