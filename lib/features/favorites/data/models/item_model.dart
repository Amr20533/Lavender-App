 /*class ItemModel {
  final String specialistid;
  final String title;
   bool isFavorite;

  ItemModel({
    required this.specialistid,
    required this.title,
    this.isFavorite = false,
  });


  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      specialistid: json['id'],
      title: json['title'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': specialistid,
      'title': title,
      'isFavorite': isFavorite,
    };
  }
 }*/
