import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'main_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.width100 * 2.5,
      height: Dimensions.height50,
      child: MainButton(
        text: 'Go to LogIn',
        onTap: () {
          // Get.to(() => SignInView());
        },
      ),
    );
  }
}
