import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/utils/images.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/features/home/presentation/screens/psstest_view.dart';
import 'package:nasma_app/features/home/presentation/screens/widgets/custom_app_bar.dart';

class DetailTestView extends StatelessWidget {
  const DetailTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            child: Center(
              child: BigText(
                text: 'Welcome ${AppConstants.userModel!.userName}',
                color: Colors.black,
                size: Dimensions.font20,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.height30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.height40,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'You\'re going to \ntake your PSS Test, \nwhich contains ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.font32,
                            ),
                            children: [
                              TextSpan(
                                text: '\n10 questions ',
                                style: TextStyle(
                                  color: AppColors.forthColor,
                                  fontSize: Dimensions.font32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: '\nto messure your stress'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                          width: double.infinity,
                        ),
                        BigText(
                          text: '*Please, Select one answer',
                          color: Colors.red,
                          size: Dimensions.font20,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height40,
                  ),
                  MainButton(
                    text: 'Go to Test',
                    onTap: () {
                      Get.offAll(() => PSSTestView());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
