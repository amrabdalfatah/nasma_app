import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/utils/images.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/features/splash/presentation/screens/splash_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: Dimensions.height70,
              backgroundImage: AssetImage(Images.logo),
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(
              height: Dimensions.height45,
              width: double.infinity,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                BigText(
                  text: 'Id',
                  color: Colors.black,
                  size: Dimensions.font20,
                ),
                BigText(
                  text: AppConstants.userModel!.id!.toString(),
                  size: Dimensions.font32,
                  color: AppColors.mainColor,
                ),
                BigText(
                  text: 'User Name',
                  color: Colors.black,
                  size: Dimensions.font20,
                ),
                BigText(
                  text: AppConstants.userModel!.userName!,
                  size: Dimensions.font32,
                  color: AppColors.mainColor,
                ),
                BigText(
                  text: 'Email',
                  color: Colors.black,
                  size: Dimensions.font20,
                ),
                BigText(
                  text: AppConstants.userModel!.email!,
                  size: Dimensions.font32,
                  color: AppColors.mainColor,
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.height45,
              width: double.infinity,
            ),
            MainButton(
              text: 'Logout',
              color: Colors.red,
              onTap: () async {
                await http
                    .post(
                  Uri.parse(ApiService.logout),
                )
                    .then((val) {
                  Get.showSnackbar(GetSnackBar(
                    title: 'Logout',
                    message: 'Logout Successfully',
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ));
                  Get.offAll(() => SplashView());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
