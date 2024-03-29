import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/settings.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("SCAN BILLETS",
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 30),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
                      child: GetBuilder<SettingsController>(
                        builder: (_) {
                          return Text("Total de billets : \t ${controller.totalToScan}");
                        },
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
                      child: GetBuilder<SettingsController>(
                        builder: (_) {
                          return Text("Billets scannés : \t ${controller.alreadyScanned}");
                        },
                      )
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    controller.updateScanCount();
                  },
                  icon: const Icon(Icons.refresh))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.removeBearerToken();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );
  }
}
