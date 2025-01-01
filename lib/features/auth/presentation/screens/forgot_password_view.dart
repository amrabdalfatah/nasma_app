import 'package:flutter/material.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/data_input.dart';
import 'package:nasma_app/core/widgets/main_button.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

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
                    DataInput(
                      text: 'Email',
                    ),
                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    MainButton(
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
