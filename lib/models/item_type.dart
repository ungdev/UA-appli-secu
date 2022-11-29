class ItemType {
  final String id;
  final String name;
  final String description;

  ItemType({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ItemType.fromJson(Map<String, dynamic> json) {
    return ItemType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
