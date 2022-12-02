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
      child: SizedBox(
        height: 75,
        child: Column(
          children: [
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
      ),
    );
  }
}
