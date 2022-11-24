import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/entrance.dart';
import 'package:ua_app_secu/models/player.dart';

class PlayerTicket extends StatefulWidget {
  const PlayerTicket({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  State<PlayerTicket> createState() => _PlayerTicketState();
}

class _PlayerTicketState extends State<PlayerTicket> {
  EntranceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Text("Player Ticket: ${widget.data['id']}");
  }
}
