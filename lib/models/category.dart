class CategoryModel {
  final int? id;
  final String icon;
  final String title;
  final int color;

  CategoryModel({
    this.id,
    required this.icon,
    required this.title,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'icon': icon,
      'title': title,
      'color': color,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      icon: map['icon'],
      title: map['title'],
      color: map['color'],
    );
  }
}
