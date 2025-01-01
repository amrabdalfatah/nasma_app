// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/data_input.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/features/auth/presentation/screens/signin_view.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
          child: SingleChildScrollView(
            child: SizedBox(
              height: Dimensions.screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: 'Sign Up',
                    color: Colors.black,
                  ),
                  DataInput(
                    text: 'User Name',
                  ),
                  DataInput(
                    text: 'Email',
                  ),
                  DataInput(
                    text: 'Password',
                  ),
                  DataInput(
                    text: 'Confirm Password',
                  ),
                  MainButton(
                    text: 'SignUp',
                    onTap: () async {
                      // try {
                      //   var response = await http.post(
                      //     Uri.parse(
                      //         'http://127.0.0.1:8000/api/v1/dj-rest-auth/registration/'),
                      //     body: {
                      //       'username': 'amrabdalfatah',
                      //       'email': 'amr@gmail.com',
                      //       'password1': 'Amr123456',
                      //       'password2': 'Amr123456',
                      //     },
                      //   );
                      //   print(response.statusCode);
                      //   print(response.body);
                      // } catch (error) {
                      //   print(error);
                      // }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmallText(
                        text: 'Have an account?',
                        size: Dimensions.font16,
                        color: Colors.black,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => SignInView());
                        },
                        child: Text('Log in'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
