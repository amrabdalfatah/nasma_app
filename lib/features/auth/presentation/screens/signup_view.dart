import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/utils/images.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/features/auth/presentation/screens/signin_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool hidePassword = true;
  bool action = false;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    action = false;
  }

  void signUp() async {
    setState(() {
      action = true;
    });
    try {
      var response = await http.post(
        Uri.parse(ApiService.registration),
        body: {
          'username': userNameController.text,
          'email': emailController.text,
          'password1': passwordController.text,
          'password2': password2Controller.text,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // TODO: save token => response.body
        Get.showSnackbar(GetSnackBar(
          title: 'Success',
          message: "Creating User Success",
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ));
        Get.offAll(() => SignInView());
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
    emailController.dispose();
    passwordController.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.bg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius15,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            text: 'Email',
                            size: Dimensions.font20,
                            color: Colors.black,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w600,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius15,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius15,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
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
                            text: 'Confirm Password',
                            size: Dimensions.font20,
                            color: Colors.black,
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w600,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: password2Controller,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radius15,
                                  ),
                                ),
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
                    SizedBox(
                      height: 20,
                    ),
                    action
                        ? Center(
                            child: CupertinoActivityIndicator(
                              color: AppColors.mainColor,
                            ),
                          )
                        : MainButton(
                            text: 'SignUp',
                            onTap: signUp,
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
                          child: Text(
                            'Log in',
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
        ),
      ),
    );
  }
}
