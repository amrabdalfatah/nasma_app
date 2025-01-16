import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/dimensions.dart';
import 'package:nasma_app/core/widgets/big_text.dart';
import 'package:nasma_app/core/widgets/main_button.dart';
import 'package:nasma_app/features/home/presentation/screens/home_view.dart';

class ChatView extends StatelessWidget {
  final int cycle;
  final String level;
  const ChatView({
    super.key,
    required this.cycle,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breathing Bot'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigText(
            text: 'Comming Soon',
            color: Colors.black,
            size: Dimensions.font32,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.height30,
              horizontal: Dimensions.height64,
            ),
            child: MainButton(
                text: 'Go Home',
                onTap: () {
                  Get.offAll(() => HomeView());
                }),
          )
        ],
      ),
    );
  }
}
