import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart';

class ItemsRepo extends StatefulWidget {
  const ItemsRepo({Key? key}) : super(key: key);

  @override
  State<ItemsRepo> createState() => _ItemsRepoState();
}

class _ItemsRepoState extends State<ItemsRepo> {
  RepoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // Item List of PC and Peripherals to click on
    return ListView.builder(
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
    );
  }
}
