import 'dart:convert';

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
      ],
    );
  }
}
