class EntrancePlayer {
  String id;
  String username;
  String firstname;
  String lastname;
  String? place;
  String type;
  String email;
  String teamName;
  String tournamentName;
  String customMessage;

  EntrancePlayer({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.place,
    required this.type,
    required this.email,
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
      email: json['email'],
      teamName: json['team']['name'],
      tournamentName: json['team']['tournament']['name'],
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
    data['email'] = email;
    data['teamName'] = teamName;
    data['tournamentName'] = tournamentName;
    data['customMessage'] = customMessage;
    return data;
  }
}
