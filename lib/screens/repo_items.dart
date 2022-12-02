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

  List<bool> isSelected = <bool>[];

  @override
  void initState() {
    super.initState();
    isSelected = List<bool>.filled(controller.repoItemTypes.length, false);
  }

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
              return Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: isSelected[index]
                        ? Theme.of(context).primaryColor.withOpacity(0.5)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(controller.repoItemTypes[index].name),
                    subtitle: Text(controller.repoItemTypes[index].description),
                    onTap: () {
                      setState(() {
                        isSelected[index] = !isSelected[index];
                      });
                      controller.selectedItemsType[index] =
                          controller.selectedItemsType[index] == 1 ? 0 : 1;
                    },
                  ));
            },
          ),
          Positioned(
            bottom: 20,
            width: MediaQuery.of(context).size.width - 40,
            child: SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  controller.changePage(repo.Page.playerRepoAdd);
                },
                child: const Text('Valider'),
              ),
            ),
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
