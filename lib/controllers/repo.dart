import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ua_app_secu/api.dart';
import 'package:ua_app_secu/controllers/scanner.dart';
import 'package:ua_app_secu/models/item.dart';
import 'package:ua_app_secu/models/item_type.dart';
import 'package:ua_app_secu/models/log.dart';
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

class RepoController extends GetxController implements ScannerController {
  Page selectedPage = Page.playerQRCode;
  // PlayerCode
  Uint8List? playerCode;
  // Player
  Player? player;
  // Current Page
  Widget? currentPage;
  // API
  Api api = Api();
  // Scanner controller
  @override
  MobileScannerController? scannerController;
  // Repo Items
  List<ItemType> repoItemTypes = [
    ItemType(
      id: 'computer',
      name: 'PC',
      description: 'Ordinateur',
    ),
    ItemType(
      id: 'monitor',
      name: 'Écran PC',
      description: 'Écran d\'ordinateur',
    ),
    ItemType(
      id: 'peripheral',
      name: 'Périphérique',
      description: 'Clavier, souris, casque, etc.',
    ),
  ];
  // Selected Item Type
  int selectedItemType = 0;
  // Select Item
  Item? selectedItem;
  // Logs
  List<Log> logs = [];

  @override
  void onInit() {
    super.onInit();
    scannerController = MobileScannerController(
      facing: CameraFacing.back,
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: [BarcodeFormat.qrCode],
      returnImage: false,
    );
    changePage(Page.playerQRCode);
  }

  void changePage(Page newPage) async {
    switch (newPage) {
      case Page.playerQRCode:
        currentPage =
            const QRCode<RepoController>(text: 'LE BILLET D\'UN JOUEUR');
        break;
      case Page.playerRepo:
        currentPage = PlayerRepo(player: player!);
        break;
      case Page.playerItems:
        currentPage = const ItemsRepo();
        break;
      case Page.playerRepoAdd:
        currentPage =
            const QRCode<RepoController>(text: 'L\'EMPLACEMENT DE DESTINATION');
        break;
      case Page.playerRepoRemove:
        currentPage =
            const QRCode<RepoController>(text: 'L\'EMPLACEMENT DE RETRAIT');
        break;
      case Page.playerLogs:
        List<Log>? logs = await api.getLogs(player!);

        if (logs != null) {
          currentPage = LogsRepo(logs: logs);
        } else {
          // TODO: add error message
          return;
        }
        break;
    }

    selectedPage = newPage;

    update();
  }

  @override
  void onScan(Uint8List code) async {
    switch (selectedPage) {
      case Page.playerQRCode:
        setPlayerCode(code);
        break;
      case Page.playerRepoAdd:
        addItemToRepo(String.fromCharCodes(code));
        break;
      case Page.playerRepoRemove:
        removeItemFromRepo(
            repoItemTypes[selectedItemType].id, String.fromCharCodes(code));
        break;
      default:
        break;
    }
  }

  void setPlayerCode(Uint8List code) async {
    playerCode = code;
    player = await api.getPlayer(playerCode!);

    player != null
        ? changePage(Page.playerRepo)
        : // (currentPage as QRCode).sendError('Le joueur n\'existe pas');
        // TODO: add error message
        null;
  }

  void selectItemType(int index) {
    selectedItemType = index;
    changePage(Page.playerRepoAdd);
  }

  void selectItem(Item item) {
    selectedItem = item;
    changePage(Page.playerRepoRemove);
  }

  void getLogs() async {
    logs = await api.getLogs(player!) ?? [];
    changePage(Page.playerLogs);
  }

  void addItem() {
    changePage(Page.playerItems);
  }

  void addItemToRepo(location) {
    // TODO : add item to repo
    changePage(Page.playerRepo);
  }

  void removeItemFromRepo(id, location) {
    // TODO : remove item from repo
    changePage(Page.playerRepo);
  }
}
