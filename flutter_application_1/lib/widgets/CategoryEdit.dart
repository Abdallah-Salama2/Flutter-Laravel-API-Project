import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Category.dart';
import 'package:flutter_application_1/services/api.dart';

class CategoryEDit extends StatefulWidget {
  final Category category;
  final Function categoryCallback;
  CategoryEDit(this.category, this.categoryCallback, {Key? key})
      : super(key: key);

  @override
  State<CategoryEDit> createState() => _CategoryEDitState();
}

class _CategoryEDitState extends State<CategoryEDit> {
  var key2 = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  String errorMsg = '';

  @override
  void initState() {
    categoryNameController.text = widget.category.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    widget.category.name = categoryNameController.text;

    await widget.categoryCallback(widget.category);
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
