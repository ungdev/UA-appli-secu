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
    return const Text("Repo Items");
  }
}
