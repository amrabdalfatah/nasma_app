import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/utils/images.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
// import 'package:nasma_app/core/widgets/data_input.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/core/widgets/small_text.dart';
import 'package:nasma_app/features/auth/presentation/screens/signup_view.dart';
import 'package:nasma_app/features/home/presentation/screens/detail_test_view.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
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
          await http
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
          Get.snackbar(
            'Success',
            "Success to Login",
            snackPosition: SnackPosition.TOP,
            colorText: Colors.green,
            duration: Duration(seconds: 6),
          );
          Get.offAll(() => DetailTestView());
        } else {
          Get.snackbar(
            'Error',
            "Error with your data",
            snackPosition: SnackPosition.TOP,
            colorText: Colors.red,
          );
        }
      } catch (error) {
        Get.snackbar(
          'Error',
          error.toString(),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      }
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.height64,
                    ),
                    BigText(
                      text: 'Log In',
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: Dimensions.height64,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "User Name is required";
                                }
                                return null;
                              },
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
                      height: Dimensions.height20,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
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
                    TextButton(
                      onPressed: () {
                        Get.to(() => ForgotPasswordView());
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: AppColors.forthColor,
                          fontStyle: FontStyle.italic,
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
                              color: AppColors.forthColor,
                              fontStyle: FontStyle.italic,
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
