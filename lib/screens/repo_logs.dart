import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart';

class LogsRepo extends StatefulWidget {
  const LogsRepo({Key? key}) : super(key: key);

  @override
  State<LogsRepo> createState() => _LogsRepoState();
}

class _LogsRepoState extends State<LogsRepo> {
  RepoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return const Text("Repo Logs");
  }
}
