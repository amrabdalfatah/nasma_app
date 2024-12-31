import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'main_button.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  Future<void> _launchUrl() async {
    // if (!await launchUrl(
    //   Uri.parse('https://wa.me/${AppConstants.phoneNumber}'),
    // )) {
    //   Get.snackbar(
    //     'Error',
    //     'Could not launch URL',
    //     snackPosition: SnackPosition.TOP,
    //     colorText: Colors.red,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.width100 * 2.5,
      height: Dimensions.height50,
      child: MainButton(
        text: 'Contact Us to Register',
        color: Colors.green,
        onTap: _launchUrl,
      ),
    );
  }
}
