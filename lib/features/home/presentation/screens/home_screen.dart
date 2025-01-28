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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>>? allTests;
  @override
  void initState() {
    super.initState();
    getPreviosTest();
  }

  void getPreviosTest() async {
    try {
      var response = await http.get(
        Uri.parse(ApiService.pssResults),
      );
      allTests = json.decode(response.body);
      print("${allTests!.length}");
    } catch (er) {
      Get.snackbar(
        "Error",
        er.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        Card(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: "Your best Test:",
                  color: AppColors.thirdColor,
                  size: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.height10,
                  width: double.infinity,
                ),
                SmallText(
                  text: 'Result: ${AppConstants.result}',
                  color: Colors.black,
                  size: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.height10,
                  width: double.infinity,
                ),
                SmallText(
                  text: 'Date : ${AppConstants.level}',
                  color: Colors.black,
                  size: Dimensions.font16,
                ),
                SizedBox(
                  height: Dimensions.height10,
                  width: double.infinity,
                ),
                BigText(
                  text: "This is the lowest stress day",
                  color: AppColors.fifthColor,
                  size: Dimensions.font16,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.height20,
          width: double.infinity,
        ),
        BigText(
          text: "All previous Test",
          color: Colors.black,
          size: Dimensions.font16,
        ),
        Expanded(
          child: FutureBuilder(
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
                    allTests.add(
                        PssResultModel.fromJson(val as Map<String, dynamic>));
                  });
                  userTests = allTests
                      .where((val) => val.userId == AppConstants.userModel!.id)
                      .toList()
                      .reversed
                      .toList();
                }

                return ListView.builder(
                    itemCount: userTests.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text:
                                    "${userTests[index].testDate!.substring(0, 10)}",
                                color: AppColors.thirdColor,
                                size: Dimensions.font16,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                                width: double.infinity,
                              ),
                              SmallText(
                                text: 'Score: ${userTests[index].score}',
                                color: Colors.black,
                                size: Dimensions.font16,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                                width: double.infinity,
                              ),
                              SmallText(
                                text: 'Level : ${userTests[index].level}',
                                color: Colors.black,
                                size: Dimensions.font16,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }),
        )
      ],
    );
  }
}
