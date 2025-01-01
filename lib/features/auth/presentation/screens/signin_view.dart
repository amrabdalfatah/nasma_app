import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/data_input.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/features/auth/presentation/screens/signup_view.dart';

import 'forgot_password_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: 'Log In',
                color: Colors.black,
              ),
              DataInput(
                text: 'Email',
              ),
              DataInput(
                text: 'Password',
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => ForgotPasswordView());
                },
                child: Text('Forgot Password?'),
              ),
              MainButton(
                text: 'login',
                onTap: () async {
                  final dio = d.Dio();

                  d.Response response;
                  response = await dio.post(
                    'localhost:8000/api/v1/dj-rest-auth/registration/',
                    data: {'email': '', 'password': 'dio'},
                  );
                  print(response.data.toString());
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallText(
                    text: 'Do\'t have an account?',
                    size: Dimensions.font16,
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => SignupView());
                    },
                    child: Text('Sign Up'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
