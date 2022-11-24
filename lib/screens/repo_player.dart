import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart';
import 'package:ua_app_secu/models/player.dart';

class PlayerRepo extends StatefulWidget {
  const PlayerRepo({Key? key, required this.player}) : super(key: key);
  final Player player;

  @override
  State<PlayerRepo> createState() => _PlayerRepoState();
}

class _PlayerRepoState extends State<PlayerRepo> {
  RepoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Text("Player Repo: ${widget.player.pseudo}");
  }
}
