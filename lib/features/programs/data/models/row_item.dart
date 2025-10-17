
class RowItem {
  final String icon;
  final String title;

  RowItem({
    required this.icon,
    required this.title,
  });
  static List<RowItem> rowItems = [
    RowItem(
      icon: "assets/icons/very_happy.png",
      title: "سعيد جدًا",
    ),
    RowItem(
      icon: "assets/icons/happy.png",
      title: "سعيد",
    ),
    RowItem(
      icon: "assets/icons/careless.png",
      title: "غير مبالٍ",
    ),
    RowItem(
      icon: "assets/icons/sad.png",
      title: "حزين",
    ),
    RowItem(
      icon: "assets/icons/angry.png",
      title: "غاضب جدًا ",
    ),
  ];

}

