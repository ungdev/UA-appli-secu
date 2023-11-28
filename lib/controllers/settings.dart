import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ua_app_secu/screens/settings.dart';
import 'package:ua_app_secu/api.dart';

class SettingsController extends GetxController {
  final page = const Settings();
  // API
  Api api = Api();
  String? bearerToken;
  int totalToScan = 0;
  int alreadyScanned = 0;

  @override
  void onInit() {
    super.onInit();
    bearerToken = GetStorage().read('token');
  }

  @override
  void onReady() {
    api.getScanCount().then((scanCount) {
      if(scanCount != null &&
          scanCount.containsKey("alreadyScanned") &&
          scanCount.containsKey("totalToScan")) {
        alreadyScanned = scanCount["alreadyScanned"];
        totalToScan = scanCount["totalToScan"];
      }
    });
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

  void updateScanCount(){
    api.getScanCount().then((scanCount) {
      if(scanCount != null &&
          scanCount.containsKey("alreadyScanned") &&
          scanCount.containsKey("totalToScan")) {

        if(alreadyScanned != scanCount["alreadyScanned"] ||
            totalToScan != scanCount["totalToScan"]) {
          alreadyScanned = scanCount["alreadyScanned"];
          totalToScan = scanCount["totalToScan"];
          update();
        }
      }
    });
  }
}
