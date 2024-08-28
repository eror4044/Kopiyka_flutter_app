import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:kopiyka/data/databases/heplers/database_helper.dart";
import "package:kopiyka/models/category.dart";

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<CategoryModel>>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<List<CategoryModel>> {
  CategoryNotifier() : super([]);

  Future<void> fetchCategories() async {
    try {
      final categories = await DatabaseHelper().getAllCategories();
      for (var element in categories) {
        state = [...state, CategoryModel.fromMap(element)];
      }
    } catch (e) {
      state = [];
      debugPrint('Error fetching Categories: $e');
    }
  }

  void addCategory(CategoryModel category) {
    //ToDo add Category to the database and update the state

    state = [...state, category];
  }
}
