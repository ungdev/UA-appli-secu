import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/api.dart';
import 'package:ua_app_secu/controllers/scanner.dart';
import 'package:ua_app_secu/models/entrance_player.dart';
import 'package:ua_app_secu/screens/qrcode.dart';
import 'package:ua_app_secu/screens/ticket_player.dart';

class EntranceController extends GetxController implements ScannerController {
  int selectedIndex = 0;
  // Player Code (via qrcode)
  Uint8List? playerCode;
  // PlayerJson
  EntrancePlayer? entrancePlayer;
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
        ? const QRCode<EntranceController>(
            text: 'LE BILLET D\'UN JOUEUR', title: "SCAN ENTRÉE")
        : PlayerTicket(entrancePlayer: entrancePlayer!);
    update();
  }

  @override
  Future<void> onScan(Uint8List? code) async {
    playerCode = code;
    Map<String, dynamic>? json = await Api().scanTicket(playerCode!);
    if (json != null) {
      entrancePlayer = EntrancePlayer.fromJson(json);
      changePage(1);
    }
  }

  String getUserTypeText(type) {
    switch (type) {
      case 'player':
        return 'Joueur';
      case 'coach':
        return 'Coach/Manager';
      case 'spectator':
        return 'Spectateur';
      case 'orga':
        return 'Orga';
      default:
        return 'Inconnu';
    }
  }
}
