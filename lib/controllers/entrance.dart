import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ua_app_secu/api.dart';
import 'package:ua_app_secu/controllers/scanner.dart';
import 'package:ua_app_secu/screens/qrcode.dart';
import 'package:ua_app_secu/screens/ticket_player.dart';

class EntranceController extends GetxController implements ScannerController {
  int selectedIndex = 0;
  // Player Code (via qrcode)
  Uint8List? playerCode;
  // PlayerJson
  Map<String, dynamic>? playerJson;
  // Current Page
  Widget? currentPage;
  // Scanner controller
  @override
  MobileScannerController? scannerController;

  @override
  void onInit() {
    super.onInit();
    scannerController = MobileScannerController(
        // facing: CameraFacing.back,
        // detectionSpeed: DetectionSpeed.noDuplicates,
        // formats: [BarcodeFormat.qrCode],
        );
    changePage(0);
  }

  void changePage(int newIndex) {
    selectedIndex = newIndex;
    currentPage = selectedIndex == 0
        ? const QRCode<EntranceController>(text: 'LE BILLET D\'UN JOUEUR')
        : PlayerTicket(data: playerJson!);
    update();
  }

  @override
  void onScan(Uint8List? code) async {
    playerCode = code;
    playerJson = await Api().scanTicket(playerCode!);
    changePage(selectedIndex + 1);
  }
}
