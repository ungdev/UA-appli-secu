import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart' as repo;
import 'package:ua_app_secu/icons.dart';
import 'package:ua_app_secu/models/player.dart';

class PlayerRepo extends StatefulWidget {
  const PlayerRepo({Key? key, required this.player}) : super(key: key);
  final Player player;

  @override
  State<PlayerRepo> createState() => _PlayerRepoState();
}

class _PlayerRepoState extends State<PlayerRepo> {
  repo.RepoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Back icon
        IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            controller.changePage(repo.Page.playerRepo);
          },
        ),
        Column(
          children: [
            const Text(
              "BIENVENUE",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.player.username,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'PLACE ${widget.player.place}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.player.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.player.items[index].type),
                    subtitle: Text(widget.player.items[index].zone),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_rounded),
                      onPressed: () {
                        controller.selectItem(widget.player.items[index]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                controller.getLogs();
              },
              child: Row(
                children: const [
                  Icon(Iconsax.archiveBook),
                  SizedBox(width: 5),
                  Text('Logs'),
                ],
              ),
            ),
          ],
        ),
        FloatingActionButton(
          onPressed: () => controller.addItem(),
          child: const Icon(Iconsax.add),
        ),
      ],
    );
  }
}
