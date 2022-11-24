import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/api.dart';
import 'package:ua_app_secu/models/player.dart';
import 'package:ua_app_secu/screens/qrcode.dart';
import 'package:ua_app_secu/screens/ticket_player.dart';

class EntranceController extends GetxController {
  int selectedIndex = 0;
  // Player Code (via qrcode)
  Uint8List? playerCode;
  // PlayerJson
  Map<String, dynamic>? playerJson;
  // Current Page
  Widget? currentPage;

  @override
  void onInit() {
    super.onInit();
    changePage(0);
  }

  void changePage(int newIndex) {
    selectedIndex = newIndex;
    currentPage = selectedIndex == 0
        ? const QRCode(text: 'LE BILLET D\'UN JOUEUR')
        : PlayerTicket(data: playerJson!);
    update();
  }

  void setPlayerCode(Uint8List? code) async {
    playerCode = code;
    playerJson = await Api().scanTicket(playerCode!);
    changePage(selectedIndex + 1);
  }
}
