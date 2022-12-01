class EntrancePlayer {
  String id;
  String username;
  String firstname;
  String lastname;
  String? place;
  String type;
  String age;
  bool hasPaid;
  String? attendant;
  String? teamName;
  String? tournamentName;
  String? customMessage;

  EntrancePlayer({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.place,
    required this.type,
    required this.age,
    required this.hasPaid,
    required this.attendant,
    required this.teamName,
    required this.tournamentName,
    required this.customMessage,
  });

  factory EntrancePlayer.fromJson(Map<String, dynamic> json) {
    return EntrancePlayer(
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      place: json['place'],
      type: json['type'],
      age: json['age'],
      hasPaid: json['hasPaid'],
      attendant: json['attendant'] != null
          ? json['attendant']['firstname'] + ' ' + json['attendant']['lastname']
          : null,
      teamName: json['team'] != null ? json['team']['name'] : null,
      tournamentName: json['team'] != null && json['team']['tournament'] != null
          ? json['team']['tournament']['name']
          : null,
      customMessage: json['customMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['place'] = place;
    data['type'] = type;
    data['age'] = age;
    data['hasPaid'] = hasPaid;
    data['attendant'] = attendant;
    data['teamName'] = teamName;
    data['tournamentName'] = tournamentName;
    data['customMessage'] = customMessage;
    return data;
  }
}
