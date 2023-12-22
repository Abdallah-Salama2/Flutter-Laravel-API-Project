// ignore_for_file: file_names, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api.dart';

class CategoryAdd extends StatefulWidget {
  final Function categoryCallback;
  // ignore: prefer_const_constructors_in_immutables
  CategoryAdd(this.categoryCallback, {Key? key}) : super(key: key);

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  var key2 = GlobalKey<FormState>();
  String errorMsg = '';

  final categoryNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ignore: prefer_const_constructors
      padding: EdgeInsets.only(top: 40, left: 10, right: 10),
      child: Container(
        child: Form(
          key: key2,
          child: Column(children: <Widget>[
            TextFormField(
              onChanged: (text) => setState(() {
                errorMsg = '';
              }),
              controller: categoryNameController,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Enter category name';
                }
                return null;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'CategoryName'),
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      print(categoryNameController.text);
                      print(Uri.base);
                      print(key2);
                      saveCategory();
                    },
                    child: Text('Save')),
                ElevatedButton(
                    onPressed: () {
                      print(categoryNameController.text);
                      print(Uri.base);
                      print(key2);
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'))
              ],
            ),
            Text(
              errorMsg,
              style: TextStyle(color: Colors.red),
            )
          ]),
        ),
      ),
    );
  }

  Future saveCategory() async {
    final form = key2.currentState;
    if (!form!.validate()) {
      return;
    }

    await widget.categoryCallback(categoryNameController.text);
    Navigator.pop(context);

    //   apiService
    //       .updateCategory(
    //           widget.category.id.toString(), categoryNameController.text)
    //       .then((category) => Navigator.pop(context))
    //       .catchError((exception) {
    //     setState(() {
    //       errorMsg = exception.toString();
    //     });
    //   });
    // }
  }
}
