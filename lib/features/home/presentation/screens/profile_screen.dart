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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: Dimensions.height70,
            backgroundImage: AssetImage(Images.basicLogo),
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
              Card(
                color: AppColors.secondColor,
                child: ListTile(
                  leading: Icon(Icons.numbers),
                  title: BigText(
                    text: AppConstants.userModel!.id!.toString(),
                    color: Colors.black,
                    size: Dimensions.font20,
                    // textAlign: TextAlign.start,
                  ),
                ),
              ),
              Card(
                color: AppColors.secondColor,
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: BigText(
                    text: AppConstants.userModel!.userName!,
                    color: Colors.black,
                    size: Dimensions.font20,
                    // textAlign: TextAlign.start,
                  ),
                ),
              ),
              Card(
                color: AppColors.secondColor,
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: BigText(
                    text: AppConstants.userModel!.email!,
                    color: Colors.black,
                    size: Dimensions.font20,
                    // textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.height45,
            width: double.infinity,
          ),
          MainButton(
            text: 'Logout',
            color: AppColors.mainColor,
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
    );
  }
}
