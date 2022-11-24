import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart';
import 'package:ua_app_secu/models/log.dart';

class LogsRepo extends StatefulWidget {
  const LogsRepo({Key? key, required this.logs}) : super(key: key);
  final List<Log> logs;

  @override
  State<LogsRepo> createState() => _LogsRepoState();
}

class _LogsRepoState extends State<LogsRepo> {
  RepoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Text("Logs Repo: ${widget.logs.length}");
  }
}
