import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/entrance.dart';
import 'package:ua_app_secu/models/entrance_player.dart';

class PlayerTicket extends StatefulWidget {
  const PlayerTicket({Key? key, required this.entrancePlayer})
      : super(key: key);
  final EntrancePlayer entrancePlayer;

  @override
  State<PlayerTicket> createState() => _PlayerTicketState();
}

class _PlayerTicketState extends State<PlayerTicket> {
  EntranceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Stack(
        children: [
          // TODO: add entrance information
          // Back icon
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              controller.changePage(0);
            },
          ),
        ],
      ),
    );
  }
}
