import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
// import 'package:nasma_app/core/widgets/data_input.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/features/auth/presentation/screens/signup_view.dart';
import 'package:nasma_app/features/home/presentation/screens/psstest_view.dart';
import 'package:nasma_app/models/user_model.dart';

import 'forgot_password_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool hidePassword = true;
  bool action = false;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    action = false;
  }

  void login() async {
    setState(() {
      action = true;
    });
    try {
      var response = await http.post(
        Uri.parse(ApiService.login),
        body: {
          'username': userNameController.text,
          'password': passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        // TODO: save token => response.body
        // Get.offAll(() => HomeView());
        List<UserModel> allUsers = [];
        var res = await http
            .get(
          Uri.parse(ApiService.user),
        )
            .then((val) {
          List users = jsonDecode(val.body);
          users.forEach((ele) {
            allUsers.add(UserModel.fromJson(ele));
          });
        });
        AppConstants.userModel = allUsers.firstWhere(
            (element) => element.userName == userNameController.text);
        Get.showSnackbar(GetSnackBar(
          title: 'Success',
          message: "Success to Login",
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ));
        Get.offAll(() => PSSTestView());
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: "Something Error",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: error.toString(),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    }
    setState(() {
      action = false;
    });
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/bird.jpg'),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: SafeArea(
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
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: Dimensions.height100,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: 'User Name',
                        size: Dimensions.font20,
                        color: Colors.black,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height100,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: 'Password',
                        size: Dimensions.font20,
                        color: Colors.black,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w600,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => ForgotPasswordView());
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: Dimensions.font16,
                    ),
                  ),
                ),
                action
                    ? Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.mainColor,
                        ),
                      )
                    : MainButton(
                        text: 'login',
                        onTap: login,
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
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
