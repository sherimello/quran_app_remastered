import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeController extends GetxController {
  RxDouble arabicFontSize = 21.0.obs;
  RxDouble englishFontSize = 15.0.obs;

  var size = Get.size;

  @override
  Future<void> onInit() async {
    super.onInit();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("arabicFontSize")) {
      arabicFontSize.value = sharedPreferences.getDouble("arabicFontSize")!;
    } else {
      arabicFontSize.value = (size.width * 0.061);
    }

    if (sharedPreferences.containsKey("englishFontSize")) {
      englishFontSize.value = sharedPreferences.getDouble("englishFontSize")!;
    } else {
      englishFontSize.value = 15.0;
    }
  }
}
