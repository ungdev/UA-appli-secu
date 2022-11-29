import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart' as repo;
import 'package:ua_app_secu/models/log.dart';

class LogsRepo extends StatefulWidget {
  const LogsRepo({Key? key, required this.logs}) : super(key: key);
  final List<Log> logs;

  @override
  State<LogsRepo> createState() => _LogsRepoState();
}

class _LogsRepoState extends State<LogsRepo> {
  repo.RepoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // Logs ViewList
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back icon
        IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            controller.changePage(repo.Page.playerRepo);
          },
        ),
        ListView.builder(
          itemCount: widget.logs.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${widget.logs[index].itemType} par ${widget.logs[index].agent.firstname} ${widget.logs[index].agent.lastname}'),
              subtitle: Text(
                DateTime.fromMillisecondsSinceEpoch(
                        widget.logs[index].timestamp)
                    .toLocal()
                    .toIso8601String(),
              ),
              textColor: widget.logs[index].action == 'added'
                  ? Colors.green
                  : Colors.red,
            );
          },
        ),
      ],
    );
  }
}
