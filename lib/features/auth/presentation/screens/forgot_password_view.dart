import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/api_service.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/main_button.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool action = false;
  final emailController = TextEditingController();

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
        Uri.parse(ApiService.passwordReset),
        body: {
          'email': emailController.text,
        },
      );
      if (response.statusCode == 200) {
        // TODO: save token => response.body
        // Get.offAll(() => HomeView());
        // Get.offAll(() => PSSTestView());
      } else {
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: "Something Error",
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: error.toString(),
        duration: Duration(seconds: 2),
      ));
    }
    setState(() {
      action = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: BigText(
                    text: 'Forgot Password',
                    color: Colors.black,
                    size: Dimensions.font20,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    action
                        ? Center(
                            child: CupertinoActivityIndicator(
                              color: AppColors.mainColor,
                            ),
                          )
                        : MainButton(
                            text: 'Send',
                            onTap: () {},
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
