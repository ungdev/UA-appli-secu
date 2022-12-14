import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart' as repo;
import 'package:ua_app_secu/models/log.dart';

class LogsRepo extends StatefulWidget {
  const LogsRepo({Key? key, required this.logs}) : super(key: key);
  final List<Log>? logs;

  @override
  State<LogsRepo> createState() => _LogsRepoState();
}

class _LogsRepoState extends State<LogsRepo> {
  repo.RepoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // Logs ViewList
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Stack(children: [
        widget.logs != null && widget.logs!.isNotEmpty
            ? ListView.builder(
                itemCount: widget.logs!.length,
                itemBuilder: (context, index) {
                  return Material(
                    elevation: 10,
                    child: ListTile(
                      title: Text(
                          '${controller.repoItemTypesFromIdToName(widget.logs![index].itemType)} ${widget.logs![index].action == 'added' ? 'déposé' : 'ajouté'} par ${widget.logs![index].agent.firstname} ${widget.logs![index].agent.lastname}'),
                      subtitle: Text(
                        DateTime.parse(widget.logs![index].timestamp)
                            .toString(),
                      ),
                      leading: widget.logs![index].action == 'added'
                          ? const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.remove_circle_outline_rounded,
                              color: Colors.red,
                            ),
                      textColor: widget.logs![index].action == 'added'
                          ? Colors.green
                          : Colors.red,
                      horizontalTitleGap: 2,
                    ),
                  );
                },
              )
            : const Center(child: Text('Aucun log')),
        // Back icon
        IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            controller.changePage(repo.Page.playerRepo);
          },
        ),
      ]),
    );
  }
}
