import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasma_app/core/utils/colors.dart';
import 'package:nasma_app/core/utils/dimensions.dart';

import '../view_model/user_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserViewModel>(
      init: UserViewModel(),
      builder: (controller) {
        return Scaffold(
          // backgroundColor: AppColors.secondColor,
          appBar: AppBar(
            backgroundColor: AppColors.secondColor,
            centerTitle: true,
            title: Text(
              controller.appBars[controller.screenIndex.value],
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(Dimensions.height30),
            child: controller.screens[controller.screenIndex.value],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.screenIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: Colors.grey[400],
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book),
                label: 'Articles',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(CupertinoIcons.settings),
              //   label: 'Settings',
              // ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                label: 'Profile',
              ),
            ],
            onTap: controller.changeScreen,
          ),
        );
      },
    );
  }
}
