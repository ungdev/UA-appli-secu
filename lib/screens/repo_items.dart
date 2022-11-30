import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart' as repo;

class ItemsRepo extends StatefulWidget {
  const ItemsRepo({Key? key}) : super(key: key);

  @override
  State<ItemsRepo> createState() => _ItemsRepoState();
}

class _ItemsRepoState extends State<ItemsRepo> {
  repo.RepoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // Item List of PC and Peripherals to click on
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Stack(
        children: [
          ListView.builder(
            itemCount: controller.repoItemTypes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.repoItemTypes[index].name),
                subtitle: Text(controller.repoItemTypes[index].description),
                onTap: () {
                  controller.selectItemType(index);
                },
              );
            },
          ),
          // Back icon
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              controller.changePage(repo.Page.playerRepo);
            },
          ),
        ],
      ),
    );
  }
}
