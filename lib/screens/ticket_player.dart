import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/entrance.dart';
import 'package:ua_app_secu/models/entrance_player.dart';

class PlayerTicket extends StatefulWidget {
  const PlayerTicket({Key? key, required this.entrancePlayer})
      : super(key: key);
  final EntrancePlayer entrancePlayer;

  @override
  State<PlayerTicket> createState() => _PlayerTicketState();
}

class _PlayerTicketState extends State<PlayerTicket> {
  EntranceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Back icon
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  controller.changePage(0);
                },
              ),
            ],
          ),
          Column(
            children: [
              Text(
                widget.entrancePlayer.username,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${widget.entrancePlayer.firstname} ${widget.entrancePlayer.lastname}",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                widget.entrancePlayer.place != null
                    ? 'PLACE ${widget.entrancePlayer.place}'
                    : 'PAS DE PLACE',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Wrap(
              runSpacing: 50,
              spacing: 50,
              alignment: WrapAlignment.center,
              children: [
                getGroup("Type",
                    controller.getUserTypeText(widget.entrancePlayer.type)),
                widget.entrancePlayer.teamName != null
                    ? getGroup("Équipe", widget.entrancePlayer.teamName!)
                    : Container(),
                widget.entrancePlayer.tournamentName != null
                    ? getGroup("Tournoi", widget.entrancePlayer.tournamentName!)
                    : Container(),
                ...getAgeGroups(),
                widget.entrancePlayer.hasPaid
                    ? getGroup("Payé", "Oui")
                    : getGroup("Payé", "Non", isImportant: true),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "Informations complémentaires",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.entrancePlayer.customMessage ??
                    'Aucune information fournie',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.changePage(0);
                },
                child: const Text('SCANNER UN AUTRE BILLET'),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     controller.changePage(0);
              //   },
              //   child: const Text('VALIDER'),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getGroup(String title, String data, {bool isImportant = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isImportant ? Theme.of(context).primaryColor : Colors.black,
          ),
        ),
      ],
    );
  }

  List<Widget> getAgeGroups() {
    List<Widget> ageGroups = [];
    if (widget.entrancePlayer.age == 'child') {
      ageGroups.add(getGroup("Age", 'Mineur', isImportant: true));
      if (widget.entrancePlayer.attendant != null) {
        ageGroups
            .add(getGroup("Accompagnateur", widget.entrancePlayer.attendant!));
      }
    } else {
      ageGroups.add(getGroup("Age", 'Majeur', isImportant: false));
    }
    return ageGroups;
  }
}
