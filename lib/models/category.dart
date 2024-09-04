class CategoryType {
  static const income = CategoryType._('income');
  static const expense = CategoryType._('expense');

  final String value;

  const CategoryType._(this.value);

  static List<CategoryType> get values => [income, expense];

  static CategoryType fromValue(String value) {
    switch (value) {
      case 'income':
        return CategoryType.income;
      case 'expense':
        return CategoryType.expense;
      default:
        throw ArgumentError('Invalid value');
    }
  }

  @override
  String toString() {
    return value;
  }
}

class CategoryModel {
  final int? id;
  final String icon;
  final String title;
  final int color;
  final CategoryType type;

  CategoryModel({
    this.id,
    required this.icon,
    required this.title,
    required this.color,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'icon': icon,
      'title': title,
      'color': color,
      'type': type.value,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      icon: map['icon'],
      title: map['title'],
      color: map['color'],
      type: CategoryType.fromValue(map['type']),
    );
  }
}
