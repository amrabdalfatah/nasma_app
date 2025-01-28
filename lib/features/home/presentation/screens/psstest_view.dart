import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/features/home/presentation/screens/breathing_session_view.dart';
import 'package:nasma_app/features/splash/presentation/screens/splash_view.dart';
import 'package:nasma_app/models/pss_test.dart';
import 'package:nasma_app/models/question_test.dart';

import 'chat_view.dart';
import 'home_view.dart';

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
    if (index == 2 || index == 3 || index == 5 || index == 6 || index == 9) {
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
      AppConstants.result = result;
      AppConstants.level = level;
      await http.post(
        Uri.parse(ApiService.pssResults),
        body: {
          "user_id": "${AppConstants.userModel!.id}",
          "test_id": "$testId",
          "score": "$result",
          "level": level,
        },
      ).then((val) {
        Get.snackbar(
          'Success',
          "Success to Add Test",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.green,
        );
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
        Get.defaultDialog(
          title: "Congratulation",
          titleStyle: TextStyle(
            color: AppColors.forthColor,
          ),
          content: Column(
            children: [
              SizedBox(
                height: Dimensions.height100,
                child: LottieBuilder.asset('assets/lottie/congrate.json'),
              ),
              SizedBox(
                height: Dimensions.height15,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'You completed Test \nYour score = ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                      text: '$result / 40',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\nYou need a ',
                    ),
                    TextSpan(
                      text: 'Breathing Session ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\nfor 30 cycle',
                    ),
                  ],
                ),
              ),
            ],
          ),
          onConfirm: () {
            // Get.offAll(
            //   () => BreathingSessionView(
            //     result: result,
            //     cycle: 30,
            //     level: level!,
            //   ),
            // );
            Get.offAll(() => HomeView());
          },
        );
      } else if (result <= 26) {
        Get.defaultDialog(
          title: "Congratulation",
          titleStyle: TextStyle(
            color: AppColors.forthColor,
          ),
          content: Column(
            children: [
              SizedBox(
                height: Dimensions.height100,
                child: LottieBuilder.asset('assets/lottie/congrate.json'),
              ),
              SizedBox(
                height: Dimensions.height15,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'You completed Test \nYour score = ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                      text: '$result / 40',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\nYou need a ',
                    ),
                    TextSpan(
                      text: 'Breathing Session ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\nfor 60 cycle',
                    ),
                  ],
                ),
              ),
            ],
          ),
          onConfirm: () {
            // Get.offAll(
            //   () => BreathingSessionView(
            //     result: result,
            //     cycle: 60,
            //     level: level!,
            //   ),
            // );
            Get.offAll(() => HomeView());
          },
        );
      } else {
        Get.defaultDialog(
          title: "Congratulation",
          titleStyle: TextStyle(
            color: AppColors.forthColor,
          ),
          content: Column(
            children: [
              SizedBox(
                height: Dimensions.height100,
                child: LottieBuilder.asset('assets/lottie/congrate.json'),
              ),
              SizedBox(
                height: Dimensions.height15,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'You completed Test \nYour score = ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                      text: '$result / 40',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\nYou need to chat with our',
                    ),
                    TextSpan(
                      text: '\nChatBot ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'after that you need a\n',
                    ),
                    TextSpan(
                      text: 'Breathing Session ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'for 90 cycle',
                    ),
                  ],
                ),
              ),
            ],
          ),
          onConfirm: () {
            Get.offAll(
              () => ChatView(
                result: result,
                cycle: 90,
                level: level!,
              ),
            );
            // Get.offAll(() => HomeView());
          },
        );
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
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      Get.offAll(() => SplashView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      body: dataLoaded!
          ? Padding(
              padding: EdgeInsets.only(
                top: Dimensions.height100,
                right: Dimensions.height30,
                left: Dimensions.height30,
                bottom: Dimensions.height30,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Card(
                          color: AppColors.forthColor,
                          child: Padding(
                            padding: EdgeInsets.all(Dimensions.height20),
                            child: Text(
                              allQuestions[index].content!,
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.snackbar(
                              'Error',
                              "You must select a circle",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.red,
                            );
                          },
                          leading: Radio(
                            value: 0,
                            groupValue: choiceVal,
                            onChanged: selectValue,
                          ),
                          title: Text(
                            allQuestions[index].answerZero!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.snackbar(
                              'Error',
                              "You must select a circle",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.red,
                            );
                          },
                          leading: Radio(
                            value: 1,
                            groupValue: choiceVal,
                            onChanged: selectValue,
                          ),
                          title: Text(
                            allQuestions[index].answerOne!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.snackbar(
                              'Error',
                              "You must select a circle",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.red,
                            );
                          },
                          leading: Radio(
                            value: 2,
                            groupValue: choiceVal,
                            onChanged: selectValue,
                          ),
                          title: Text(
                            allQuestions[index].answerTwo!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.snackbar(
                              'Error',
                              "You must select a circle",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.red,
                            );
                          },
                          leading: Radio(
                            value: 3,
                            groupValue: choiceVal,
                            onChanged: selectValue,
                          ),
                          title: Text(
                            allQuestions[index].answerThree!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.snackbar(
                              'Error',
                              "You must select a circle",
                              snackPosition: SnackPosition.TOP,
                              colorText: Colors.red,
                            );
                          },
                          leading: Radio(
                            value: 4,
                            groupValue: choiceVal,
                            onChanged: selectValue,
                          ),
                          title: Text(
                            allQuestions[index].answerFour!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    min: 0,
                    max: 10,
                    value: index.toDouble() + 1,
                    onChanged: (val) {},
                    activeColor: AppColors.mainColor,
                  ),
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
