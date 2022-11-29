class Agent {
  final String firstname;
  final String lastname;

  Agent({
    required this.firstname,
    required this.lastname,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}

class Log {
  final String itemId;
  final String itemType;
  final String action;
  final int timestamp;
  final Agent agent;

  Log({
    required this.itemId,
    required this.itemType,
    required this.action,
    required this.timestamp,
    required this.agent,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      itemId: json['itemId'],
      itemType: json['itemType'],
      action: json['action'],
      timestamp: json['timestamp'],
      agent: Agent.fromJson(json['agent']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['itemType'] = itemType;
    data['action'] = action;
    data['timestamp'] = timestamp;
    data['agent'] = agent.toJson();
    return data;
  }
}
