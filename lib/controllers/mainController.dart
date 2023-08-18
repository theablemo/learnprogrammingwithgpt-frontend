import 'package:get/get_state_manager/get_state_manager.dart';

enum LocaleEnum { FA, EN }

class MainController extends GetxController {
  LocaleEnum locale = LocaleEnum.EN;

  void setLocale(LocaleEnum value) {
    locale = value;

    update();
  }
}
