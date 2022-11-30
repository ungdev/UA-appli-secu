class Item {
  final String id;
  final String type;
  final String zone;

  Item({
    required this.id,
    required this.type,
    required this.zone,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      type: json['type'],
      zone: json['zone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['zone'] = zone;
    return data;
  }
}
