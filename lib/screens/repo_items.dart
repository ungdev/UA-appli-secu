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

  List<TextEditingController> _textFieldControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    _textFieldControllers = List<TextEditingController>.generate(
        controller.repoItemTypes.length,
        (int index) => new TextEditingController(text: "0"),
        growable: false);
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldControllers.forEach((controller) { controller.dispose(); });
  }

  // TODO - besoin ? avoir l'inventaire d'une zone

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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(controller.repoItemTypes[index].name),
                    subtitle: Text(controller.repoItemTypes[index].description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Theme.of(context).primaryColor),
                          onPressed: (){
                            int itemCount = int.parse(_textFieldControllers[index].text);
                            if(itemCount > 0) {
                              _textFieldControllers[index].text = (itemCount-1).toString();
                            }
                          },
                        ),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            controller: _textFieldControllers[index],
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: const InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                            ),
                            onTapOutside: (event) {
                              if(_textFieldControllers[index].text.isEmpty){
                                _textFieldControllers[index].text = "0";
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                          onPressed: (){
                            int itemCount = int.parse(_textFieldControllers[index].text);
                            if(itemCount < 99) {
                              _textFieldControllers[index].text = (itemCount+1).toString();
                            }
                          },
                        ),
                      ],
                    )
                  )
              );
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
                  controller.itemsTypeQuantities = _textFieldControllers.map((tfControl) => int.parse(tfControl.text)).toList(growable: false);
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
