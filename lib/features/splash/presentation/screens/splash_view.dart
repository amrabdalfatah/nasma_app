import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/images.dart';
import 'deatil_app_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        timer.cancel();
        Get.off(() => const DeatilAppView());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(
              Dimensions.height10,
            ),
            child: SizedBox(
              height: Dimensions.screenHeight * 0.4,
              child: Image.asset(
                Images.logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
            width: double.infinity,
            child: const CupertinoActivityIndicator(
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
