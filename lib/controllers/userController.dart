import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/user.dart';

class UserController extends GetxController {
  User user = User(name: "name", introText: "introText", id: "id");

  void setUser(User value) {
    user = value;
    update();
  }
}
