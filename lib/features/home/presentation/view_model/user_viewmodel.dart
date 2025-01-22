import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nasma_app/app.dart';
import 'package:nasma_app/features/home/presentation/screens/home_screen.dart';
import 'package:nasma_app/features/home/presentation/screens/profile_screen.dart';
import 'package:nasma_app/models/user_model.dart';

import '../screens/article_screen.dart';
// import '../screens/setting_screen.dart';

class UserViewModel extends GetxController {
  UserModel? userData;

  List<Widget> screens = const [
    HomeScreen(),
    ArticleScreen(),
    // SettingScreen(),
    ProfileScreen(),
  ];
  List<String> appBars = [
    'Home',
    'Articles',
    // 'Setting',
    'Profile',
  ];
  RxBool action = false.obs;
  ValueNotifier<bool> dataLoaded = ValueNotifier(true);
  ValueNotifier<int> screenIndex = ValueNotifier(0);
  RxInt catIndex = 0.obs;

  Future<void> getUser() async {
    // Code to get user
    dataLoaded.value = true;
    update();
  }

  void changeScreen(int selected) {
    screenIndex.value = selected;
    update();
  }

  void signOut() async {
    final box = GetStorage();
    box.remove('userid');
    box.remove('usertype');
    Get.offAll(() => Controller().mainScreen);
  }
}
