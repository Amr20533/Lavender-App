class SessionItem {
  final String name;
  final String description;

  SessionItem({
    required this.name,
    required this.description,
  });

  factory SessionItem.fromJson(Map<String, dynamic> json) {
    return SessionItem(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}