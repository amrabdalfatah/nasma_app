import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/features/home/presentation/screens/breathing_session_view.dart';
import 'package:nasma_app/models/pss_test.dart';
import 'package:nasma_app/models/question_test.dart';

import 'chat_view.dart';

class PSSTestView extends StatefulWidget {
  const PSSTestView({super.key});

  @override
  State<PSSTestView> createState() => _PSSTestViewState();
}

class _PSSTestViewState extends State<PSSTestView> {
  List<QuestionTestModel> allQuestions = [];
  int? choiceVal;
  bool? dataLoaded;
  int result = 0;
  int index = 0;
  int? testId;
  int? sessionId;
  int? duration;
  String? level;

  @override
  void initState() {
    super.initState();
    getAllQuestions();
  }

  Future<void> showSelected() async {
    await Future.delayed(Duration(milliseconds: 300));
  }

  void selectValue(int? val) async {
    choiceVal = val;
    if (index == 3 || index == 4 || index == 6 || index == 7) {
      choiceVal == 0
          ? result += 4
          : choiceVal == 1
              ? result += 3
              : choiceVal == 2
                  ? result += 2
                  : choiceVal == 3
                      ? result += 1
                      : result += 0;
    } else {
      result += choiceVal!;
    }
    setState(() {});
    if (index < 9) {
      await showSelected();
      choiceVal = 8;
      index++;
      setState(() {});
    } else {
      await http.post(
        Uri.parse(ApiService.pssTest),
        body: {
          'title': DateTime.now().toString().substring(0, 10),
          'description': 'This is the date for this test',
        },
      ).then((value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          PSSTestModel testModel = PSSTestModel.fromJson(
              jsonDecode(value.body) as Map<String, dynamic>);
          testId = testModel.id;
          if (result <= 13) {
            level = "Low";
            duration = 5 * 60;
          } else if (result <= 26) {
            level = "Moderate";
            duration = 10 * 60;
          } else {
            level = "High";
            duration = 15 * 60;
          }
        }
      });
      await http.post(
        Uri.parse(ApiService.pssResults),
        body: {
          "user_id": "${AppConstants.userModel!.id}",
          "test_id": "$testId",
          "score": "$result",
          "level": level,
        },
      ).then((val) {
        Get.showSnackbar(GetSnackBar(
          title: 'Success',
          message: "Success to Add Test",
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ));
      });
      await http.post(
        Uri.parse(ApiService.breathingSession),
        body: {
          "duration": "$duration",
          "session_type": level,
        },
      ).then((val) {
        sessionId = jsonDecode(val.body)['id'];
      });
      await http.post(
        Uri.parse(ApiService.userBreathingSession),
        body: {
          "user_id": "${AppConstants.userModel!.id}",
          "session_id": "$sessionId",
        },
      );

      if (result <= 13) {
        Get.offAll(() => BreathingSessionView(cycle: 20, level: level!));
      } else if (result <= 26) {
        Get.offAll(() => BreathingSessionView(cycle: 40, level: level!));
      } else {
        Get.offAll(() => ChatView());
        // Get.offAll(() => BreathingSessionView(cycle: 60, level: level));
        level = "High";
        duration = 15 * 60;
      }
    }
  }

  void getAllQuestions() async {
    setState(() {
      dataLoaded = false;
    });
    try {
      var response = await http.get(
        Uri.parse(ApiService.questions),
      );
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        data.forEach((element) {
          allQuestions.add(QuestionTestModel.fromJson(element));
        });
        setState(() {
          dataLoaded = true;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PSS Test'),
        backgroundColor: AppColors.mainColor,
      ),
      body: dataLoaded!
          ? Padding(
              padding: EdgeInsets.all(Dimensions.height30),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Card(
                          color: AppColors.mainColor,
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.height10),
                            child: Text(
                              allQuestions[index].content!,
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 0,
                              groupValue: choiceVal,
                              onChanged: selectValue,
                            ),
                            Text(
                              allQuestions[index].answerZero!,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: choiceVal,
                              onChanged: selectValue,
                            ),
                            Text(
                              allQuestions[index].answerOne!,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: choiceVal,
                              onChanged: selectValue,
                            ),
                            Text(
                              allQuestions[index].answerTwo!,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 3,
                              groupValue: choiceVal,
                              onChanged: selectValue,
                            ),
                            Text(
                              allQuestions[index].answerThree!,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 4,
                              groupValue: choiceVal,
                              onChanged: selectValue,
                            ),
                            Text(
                              allQuestions[index].answerFour!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    min: 0,
                    max: 9,
                    value: index.toDouble(),
                    onChanged: (val) {},
                    activeColor: AppColors.mainColor,
                  ),
                  // SizedBox(
                  //   height: Dimensions.height100,
                  //   width: double.infinity,
                  //   child: Center(
                  //     child: Container(
                  //       height: Dimensions.height50,
                  //       width: Dimensions.height50,
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border: Border.all(
                  //           color: AppColors.mainColor,
                  //           width: 2,
                  //         ),
                  //       ),
                  //       child: Text(
                  //         "${index + 1}",
                  //         style: TextStyle(
                  //           fontSize: Dimensions.font32,
                  //           color: AppColors.mainColor,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          : Center(
              child: CupertinoActivityIndicator(
                color: AppColors.mainColor,
              ),
            ),
    );
  }
}
