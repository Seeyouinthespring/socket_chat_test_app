class MenuItemModel {
  final String title;
  final String id;
  final bool isSelected;

  MenuItemModel({required this.title, required this.id, required this.isSelected});

  factory MenuItemModel.fromJson(dynamic json) {
    return MenuItemModel(
      title: json['title'] ?? "",
      id: json['id'] ?? "",
      isSelected: false
    );
  }
}
