import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/utils/images.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/models/pss_result.dart';
import 'package:nasma_app/models/user_session.dart';

import 'widgets/show_duration.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedDay = "Day";
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  // List<Map<String, dynamic>>? allTests;
  List<PssResultModel> testsDay = [];
  List<PssResultModel> testsMonth = [];
  List<PssResultModel> testsYear = [];
  List<PssResultModel> testsWeek = [];
  @override
  void initState() {
    super.initState();
    // getPreviosTest();
  }

  // void getPreviosTest() async {
  //   try {
  //     var response = await http.get(
  //       Uri.parse(ApiService.pssResults),
  //     );
  //     allTests = json.decode(response.body);
  //     print("${allTests!.length}");
  //   } catch (er) {
  //     print(er);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(
        Uri.parse(ApiService.pssResults),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        List<PssResultModel> userTests = [];
        if (snapshot.hasData) {
          List alldata = jsonDecode(snapshot.data!.body);
          List<PssResultModel> allTests = [];
          alldata.forEach((val) {
            allTests.add(PssResultModel.fromJson(val as Map<String, dynamic>));
          });
          userTests = allTests
              .where((val) => val.userId == AppConstants.userModel!.id)
              .toList()
              .reversed
              .toList();
        }
        testsYear = [];
        testsMonth = [];
        testsDay = [];
        userTests.forEach((item) {
          if (year == int.parse(item.testDate!.substring(0, 4))) {
            // testsYear.add(item);
          }
          if (month == int.parse(item.testDate!.substring(5, 7))) {
            testsMonth.add(item);
          }
          if (day == int.parse(item.testDate!.substring(8, 10))) {
            testsDay.add(item);
          }
        });
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: Dimensions.radius30,
                  backgroundImage: AssetImage(Images.basicLogo),
                  backgroundColor: AppColors.secondColor,
                ),
                SizedBox(width: Dimensions.width10),
                BigText(
                  text: "Welcome ${AppConstants.userModel!.userName}",
                  color: Colors.black,
                  size: Dimensions.font16,
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            BigText(
              text: "Breathing Sessions",
              color: Colors.black,
              size: Dimensions.font20,
            ),
            FutureBuilder(
              future: http.get(
                Uri.parse(ApiService.userBreathingSession),
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }

                List<UserSession> userSessions = [];
                int durations = 0;
                if (snapshot.hasData) {
                  final List alldata = jsonDecode(snapshot.data!.body);
                  alldata.forEach(
                    (item) {
                      if (item['user_id'] == AppConstants.userModel!.id) {
                        print(AppConstants.userModel!.id);
                        print(item['user_id']);
                        userSessions.add(UserSession.fromJson(item));
                        // durations += item["session_id"]["duration"] as int;
                      }
                    },
                  );
                }
                return ShowDuration(
                  sessions: userSessions,
                );
              },
            ),
            SizedBox(
              height: Dimensions.height20,
              width: double.infinity,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = "Day";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height10),
                      decoration: BoxDecoration(
                        color:
                            selectedDay == "Day" ? AppColors.secondColor : null,
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius30),
                          bottomLeft: Radius.circular(Dimensions.radius30),
                        ),
                      ),
                      child: Center(
                        child: Text('Day'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = "Week";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height10),
                      decoration: BoxDecoration(
                        color: selectedDay == "Week"
                            ? AppColors.secondColor
                            : null,
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      child: Center(
                        child: Text('Week'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = "Month";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height10),
                      decoration: BoxDecoration(
                        color: selectedDay == "Month"
                            ? AppColors.secondColor
                            : null,
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      child: Center(
                        child: Text('Month'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = "Year";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height10),
                      decoration: BoxDecoration(
                        color: selectedDay == "Year"
                            ? AppColors.secondColor
                            : null,
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius30),
                          bottomRight: Radius.circular(Dimensions.radius30),
                        ),
                      ),
                      child: Center(
                        child: Text('Year'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.height20,
              width: double.infinity,
            ),
            BigText(
              text: "$selectedDay Tests",
              color: Colors.black,
              size: Dimensions.font20,
            ),
            Expanded(
              child: ListView.builder(
                  // itemCount: userTests.length,
                  itemCount: selectedDay == "Day"
                      ? testsDay.length
                      : selectedDay == "Month"
                          ? testsMonth.length
                          : selectedDay == "Week"
                              ? testsDay.length
                              : userTests.length,
                  itemBuilder: (context, index) {
                    List<PssResultModel> pssResults = selectedDay == "Day"
                        ? testsDay
                        : selectedDay == "Week"
                            ? testsDay
                            : selectedDay == "Month"
                                ? testsMonth
                                : userTests;
                    return Card(
                      color: AppColors.secondColor,
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.height10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text:
                                  "${pssResults[index].testDate!.substring(0, 10)}",
                              color: AppColors.thirdColor,
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                              width: double.infinity,
                            ),
                            SmallText(
                              text: 'Score: ${pssResults[index].score}',
                              color: Colors.black,
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                              width: double.infinity,
                            ),
                            SmallText(
                              text: 'Level : ${pssResults[index].level}',
                              color: Colors.black,
                              size: Dimensions.font16,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        );
      },
    );
  }
}
