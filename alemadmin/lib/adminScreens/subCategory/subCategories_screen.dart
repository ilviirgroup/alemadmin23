import 'package:alemadmin/adminScreens/category/add_category.dart';
import 'package:alemadmin/adminScreens/subCategory/add_sub_category.dart';
import 'package:alemadmin/adminScreens/subCategory/subCategory_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class SubCategories extends StatelessWidget {
  static const String id = "sub_category";

  final String categoryName;
  final int categoryId;
  final String categoryAlemId;
  SubCategories({this.categoryName, this.categoryId, this.categoryAlemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddSubCategory(categoryId: categoryId)));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.library_add,
                      size: 22,
                      color: Colors.blue[700],
                    ),
                    Text(
                      'Добавить',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700]),
                    ),
                  ],
                )),
          )
        ],
      ),
      body: Container(
        color: Colors.black12,
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('subcategory').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }

            final subCategories = snapshot.data.docs.reversed;
            List<SubCategoryItem> subCategoryList = [];
            for (var item in subCategories) {
              final name = item.data()['name'];
              final catId = item.data()['category'];
              final subCategoryId = item.data()['id'];
              final documentId = item.data()['documentId'];
              final subCategoryitem = SubCategoryItem(
                documentId: documentId,
                name: name,
                subCategoryId: subCategoryId,
                categoryAlemId: categoryAlemId,
              );
              if (categoryId == catId) {
                subCategoryList.add(subCategoryitem);
              }
            }
            return ListView(
              children: subCategoryList,
              padding: EdgeInsets.all(10.0),
            );
          },
        ),
      ),
    );
  }
}
