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
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Back icon
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  controller.changePage(repo.Page.playerQRCode);
                },
              ),
            ],
          ),
          Column(
            children: [
              const Text(
                "BIENVENUE",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.player.username,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'PLACE ${widget.player.place}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 20);
                  },
                  shrinkWrap: true,
                  itemCount: widget.player.items.length,
                  itemBuilder: (context, index) {
                    return Material(
                      elevation: 3,
                      borderRadius: BorderRadiusGeometry.lerp(
                          BorderRadius.circular(20),
                          BorderRadius.circular(20),
                          20),
                      child: ListTile(
                        title: Text(controller.repoItemTypesFromIdToName(
                            widget.player.items[index].type)),
                        subtitle: Text(widget.player.items[index].zone),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline_rounded),
                          color: Colors.red,
                          onPressed: () {
                            controller.selectItem(widget.player.items[index]);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
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
              FloatingActionButton(
                onPressed: () => controller.addItem(),
                child: const Icon(Iconsax.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
