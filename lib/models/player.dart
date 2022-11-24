import 'package:ua_app_secu/models/item.dart';

class Player {
  final String id;
  final String pseudo;
  final String firstname;
  final String lastname;
  final String place;
  final List<Item> items;

  Player({
    required this.id,
    required this.pseudo,
    required this.firstname,
    required this.lastname,
    required this.place,
    required this.items,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    List<Item> items = [];
    for (var item in json['repoItems']) {
      items.add(Item.fromJson(item));
    }

    return Player(
      id: json['id'],
      pseudo: json['pseudo'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      place: json['place'],
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pseudo'] = pseudo;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['place'] = place;
    data['items'] = items;
    return data;
  }
}
