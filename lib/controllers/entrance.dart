import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/screens/qrcode.dart';
import 'package:ua_app_secu/models/player.dart';
import 'package:ua_app_secu/screens/ticket_player.dart';

class EntranceController extends GetxController {
  int selectedIndex = 0;
  // Player Code (via qrcode)
  Uint8List? playerCode;
  // Player
  Player? player;
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
        ? const Center(child: Text("Work In Progress"))
        //const QRCode(text: 'LE BILLET D\'UN JOUEUR')
        : PlayerTicket(player: player!);
    update();
  }

  void setPlayerCode(Uint8List? code) {
    playerCode = code;

    // TODO : get player from API

    changePage(selectedIndex + 1);
  }
}
