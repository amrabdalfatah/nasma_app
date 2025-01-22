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
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Images.mainLogo,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Dimensions.height15,
              width: double.infinity,
              child: const CupertinoActivityIndicator(
                color: AppColors.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
