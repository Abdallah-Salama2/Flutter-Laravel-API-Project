// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Category.dart';
import 'package:flutter_application_1/providers/CategoryProvider.dart';
import 'package:flutter_application_1/widgets/CategoryAdd.dart';
import 'package:flutter_application_1/widgets/CategoryEdit.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories', style: TextStyle(fontSize: 15)),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          Category category = categories[index];

          return ListTile(
            title: Text(category.name),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return CategoryEDit(category, provider.updateCategory);
                      });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Are u sure u want to delete'),
                          actions: [
                            TextButton(
                                onPressed: () => deleteCategory(
                                    provider.deleteCategory, category),
                                child: Text('Confirm')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel')),
                          ],
                        );
                      });
                },
              ),
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return CategoryAdd(provider.addCategory);
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future deleteCategory(Function callback, Category category) async {
    await callback(category);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
