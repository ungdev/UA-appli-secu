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
  final String action;
  final String timestamp;
  final Agent agent;

  Log({
    required this.itemId,
    required this.action,
    required this.timestamp,
    required this.agent,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      itemId: json['itemId'],
      action: json['action'],
      timestamp: json['timestamp'],
      agent: Agent.fromJson(json['agent']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemId'] = itemId;
    data['action'] = action;
    data['timestamp'] = timestamp;
    data['agent'] = agent.toJson();
    return data;
  }
}
