import 'package:get/get.dart';

class SettingsController extends GetxController{
  RxBool isThemeClicked = false.obs;

  void triggerThemeClicked() {
    isThemeClicked.value = !isThemeClicked.value;
  }

}