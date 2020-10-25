import 'package:alemadmin/adminScreens/category/add_category.dart';
import 'package:alemadmin/adminScreens/product/add_product.dart';
import 'package:alemadmin/adminScreens/subCategory/subCategories_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  static const String id = 'categories';
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  TextEditingController categoryController = TextEditingController();

  String text;

  @override
  void initState() {
    super.initState();
    categoryController.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Категории"),
        centerTitle: false,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddCategory()));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
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
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("category").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            // itemExtent: 80.0,
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot kategoriya = snapshot.data.documents[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onLongPress: () => {
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
                              FirebaseFirestore.instance
                                  .collection('category')
                                  .doc(kategoriya.data()['documentId'])
                                  .delete();
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
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => SubCategories(
                          categoryName: kategoriya.data()['name'],
                          categoryId: kategoriya.data()['id'],
                          categoryAlemId: kategoriya.data()['alemid'],
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Container(
                      color: Colors.black45,
                      child: Image.network(kategoriya.data()['url']),
                    ),
                    footer: GridTileBar(
                      leading: Text(
                        kategoriya.data()['id'].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.black45,
                      title: Text(
                        kategoriya.data()['name'],
                        textAlign: TextAlign.start,
                      ),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                ),
              );
            },
          );
        },

// This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
