import 'package:alemadmin/adminScreens/product/products_screen.dart';
import 'package:alemadmin/adminScreens/subCategory/update_sub_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance.collection('subcategory');

class SubCategoryItem extends StatelessWidget {
  final String documentId;
  final String name;
  final int subCategoryId;
  final String categoryAlemId;

  SubCategoryItem({
    this.documentId,
    this.name,
    this.subCategoryId,
    this.categoryAlemId,
  });

  deleteSubCategory(documentId) async {
    _firestore.doc(documentId).delete().catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UpdateSubCategory(
                    documentId: documentId,
                    name: name,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          title: GestureDetector(
              onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Products(
                          subCategoryName: name,
                          subId: subCategoryId,
                          categoryAlemId: categoryAlemId,
                        ),
                      ),
                    )
                  },
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
          subtitle: Text('id: $subCategoryId'),
          trailing: GestureDetector(
            onTap: () => {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  content: Text('Вы хотите удалить?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'НЕТ',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        _firestore.doc(documentId).delete();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Удалить',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                  ],
                ),
              ),
            },
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
