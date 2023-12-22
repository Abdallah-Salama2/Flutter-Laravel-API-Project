import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Category.dart';
import 'package:flutter_application_1/providers/authProvider.dart';
import 'package:flutter_application_1/services/api.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  late ApiService apiService;

  CategoryProvider() {
    this.apiService = ApiService();

    init();
  }

  Future init() async {
    categories = await apiService.fetchCategories();
    notifyListeners();
  }

  Future updateCategory(Category category) async {
    try {
      Category updatedCategory = await apiService.updateCategory(category);
      int index = categories.indexOf(category);
      categories[index] = updatedCategory;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future<void> addCategory(String name) async {
    try {
      Category addedCategory = await apiService.addCategory(name);
      categories.add(addedCategory);
      notifyListeners();
    } catch (error) {
      print('Error adding category: $error');
    }
  }

  Future<void> deleteCategory(Category category) async {
    try {
      await apiService.deleteCategory(category.id);
      categories.remove(category);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}
