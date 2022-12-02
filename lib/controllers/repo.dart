import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ua_app_secu/api.dart';
import 'package:ua_app_secu/controllers/scanner.dart';
import 'package:ua_app_secu/models/item.dart';
import 'package:ua_app_secu/models/item_type.dart';
import 'package:ua_app_secu/models/log.dart';
import 'package:ua_app_secu/screens/blank.dart';
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
  blank
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
        currentPage = const QRCode<RepoController>(
            text: 'LE BILLET D\'UN JOUEUR', title: "VESTIAIRE");
        break;
      case Page.playerRepo:
        await refreshPlayer();
        if (player != null) currentPage = PlayerRepo(player: player!);
        null;

        break;
      case Page.playerItems:
        currentPage = const ItemsRepo();
        break;
      case Page.playerRepoAdd:
        currentPage = const QRCode<RepoController>(
            text: 'L\'EMPLACEMENT DE DESTINATION', title: "AJOUTER UN OBJET");
        break;
      case Page.playerRepoRemove:
        currentPage = QRCode<RepoController>(
            text: 'L\'EMPLACEMENT DE RETRAIT',
            title: "ENLEVER ${selectedItem!.zone.toUpperCase()}");
        break;
      case Page.playerLogs:
        currentPage = LogsRepo(logs: logs);
        break;
      case Page.blank:
        currentPage = const Blank();
        break;
    }

    selectedPage = newPage;

    update();
  }

  @override
  Future<void> onScan(Uint8List code) async {
    switch (selectedPage) {
      case Page.playerQRCode:
        await setPlayerCode(code);
        break;
      case Page.playerRepoAdd:
        await addItemToRepo(String.fromCharCodes(code));
        break;
      case Page.playerRepoRemove:
        await removeItemFromRepo(String.fromCharCodes(code));
        break;
      default:
        break;
    }
  }

  Future<void> setPlayerCode(Uint8List code) async {
    playerCode = code;
    await refreshPlayer();
    changePage(Page.playerRepo);
  }

  Future<void> refreshPlayer() async {
    player = await api.getPlayer(playerCode!);

    update();
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

  Future<void> addItemToRepo(zone) async {
    List<Item> items = [
      Item(id: '', type: repoItemTypes[selectedItemType].id, zone: zone),
    ];
    await api.addPlayerItem(player!, items);
    changePage(Page.playerRepo);
  }

  Future<void> removeItemFromRepo(zone) async {
    if (selectedItem!.zone == zone) {
      await api.removePlayerItems(player!, selectedItem!);
      changePage(Page.playerRepo);
    } else {
      showError("La zone scannée ne correspond pas à l'emplacement de l'item");
    }
  }

  void showError(message) {
    Get.snackbar(
      'Error',
      message,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      backgroundColor: Colors.black87.withOpacity(0.4),
      colorText: Colors.white,
      borderRadius: 20,
    );
  }

  String repoItemTypesFromIdToName(String id) {
    return repoItemTypes.firstWhere((element) => element.id == id).name;
  }
}
