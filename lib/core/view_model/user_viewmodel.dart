import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nasma_app/app.dart';
import 'package:nasma_app/core/utils/constants.dart';
import 'package:nasma_app/features/home/home_screen.dart';
import 'package:nasma_app/features/home/profile_screen.dart';
import 'package:nasma_app/models/user_model.dart';

class UserViewModel extends GetxController {
  UserModel? userData;

  List<Widget> screens = const [
    HomeScreen(),
    ProfileScreen(),
  ];
  List<String> appBars = [
    'Home',
    'Profile',
  ];
  RxBool action = false.obs;
  ValueNotifier<bool> dataLoaded = ValueNotifier(true);
  ValueNotifier<int> screenIndex = ValueNotifier(0);
  RxInt catIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (!AppConstants.isGuest!) {
      getUser();
    }
  }

  Future<void> getUser() async {
    dataLoaded.value = false;
    // await FireStoreStudent()
    //     .getCurrentStudent(AppConstants.userId!)
    //     .then((value) {
    //   studentData =
    //       StudentModel.fromJson(value.data() as Map<dynamic, dynamic>?);
    // }).whenComplete(
    //   () {},
    // );
    dataLoaded.value = true;
    update();
  }

  void changeScreen(int selected) {
    screenIndex.value = selected;
    update();
  }

  void changeCat(int index) {
    catIndex.value = index;
    update();
  }

  void signOut() async {
    // await FirebaseAuth.instance.signOut();
    final box = GetStorage();
    box.remove('userid');
    box.remove('usertype');
    Get.offAll(() => Controller().mainScreen);
  }
}
