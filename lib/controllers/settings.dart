import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ua_app_secu/screens/settings.dart';

class SettingsController extends GetxController {
  final page = const Settings();

  String? bearerToken;

  @override
  void onInit() {
    super.onInit();
    bearerToken = GetStorage().read('token');
  }

  void setBearerToken(String token) {
    GetStorage box = GetStorage();
    box.write('token', token);

    bearerToken = token;
    update();
  }

  void removeBearerToken() {
    GetStorage box = GetStorage();
    box.remove('token');

    bearerToken = null;
    update();
  }
}
