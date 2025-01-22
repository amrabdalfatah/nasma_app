import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/widgets/big_text.dart';
import '../../../../core/widgets/login_button.dart';

class DeatilAppView extends StatefulWidget {
  const DeatilAppView({super.key});

  @override
  State<DeatilAppView> createState() => _DeatilAppViewState();
}

class _DeatilAppViewState extends State<DeatilAppView> {
  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    screenHeight = Dimensions.screenHeight;
  }

  void changeScreen() {
    setState(() {
      screenHeight = Dimensions.screenHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeScreen();
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Images.background,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.height15,
                right: Dimensions.height15,
                top: screenHeight * 0.03,
              ),
              child: const LoginButton(),
            ),
            SizedBox(
              height: screenHeight * 0.15,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
