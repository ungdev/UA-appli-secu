import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/api.dart';
import 'package:ua_app_secu/screens/repo_items.dart';
import 'package:ua_app_secu/screens/repo_logs.dart';
import 'package:ua_app_secu/screens/qrcode.dart';
import 'package:ua_app_secu/models/player.dart';
import 'package:ua_app_secu/screens/repo_player.dart';

enum Page {
  playerQRCode,
  playerRepo,
  playerItems,
  playerRepoAdd,
  playerRepoRemove,
  playerLogs,
}

class RepoController extends GetxController {
  Page selectedPage = Page.playerQRCode;
  // PlayerCode
  Uint8List? playerCode;
  // Player
  Player? player;
  // Current Page
  Widget? currentPage;
  // API
  Api api = Api();

  @override
  void onInit() {
    super.onInit();
    changePage(Page.playerQRCode);
  }

  void changePage(Page newPage) async {
    selectedPage = newPage;

    switch (selectedPage) {
      case Page.playerQRCode:
        currentPage = const QRCode(text: 'LE BILLET D\'UN JOUEUR');
        break;
      case Page.playerRepo:
        currentPage = PlayerRepo(player: player!);
        break;
      case Page.playerItems:
        currentPage = const ItemsRepo();
        break;
      case Page.playerRepoAdd:
        currentPage = const QRCode(text: 'L\'EMPLACEMENT DE DESTINATION');
        break;
      case Page.playerRepoRemove:
        currentPage = const QRCode(text: 'L\'EMPLACEMENT DE RETRAIT');
        break;
      case Page.playerLogs:
        currentPage = const LogsRepo();
        break;
    }

    update();
  }

  void setPlayerCode(Uint8List code) async {
    playerCode = code;
    player = await api.getPlayer(playerCode!);

    player != null
        ? changePage(Page.playerRepo)
        : // (currentPage as QRCode).sendError('Le joueur n\'existe pas');
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Le joueur n\'existe pas')));
  }

  void addItemToRepo(location) {
    // TODO : add item to repo
    changePage(Page.playerRepo);
  }

  void removeItemToRepo(id, location) {
    // TODO : remove item from repo
    changePage(Page.playerRepo);
  }
}
