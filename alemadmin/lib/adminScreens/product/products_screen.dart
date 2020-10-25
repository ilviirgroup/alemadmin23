import 'package:alemadmin/adminScreens/product/add_color.dart';
import 'package:alemadmin/adminScreens/product/add_product.dart';
import 'package:alemadmin/adminScreens/product/add_size.dart';
import 'package:alemadmin/adminScreens/product/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class Products extends StatefulWidget {
  final String subCategoryName;
  final int subId;
  final String categoryAlemId;
  Products({
    this.subCategoryName,
    this.subId,
    this.categoryAlemId,
  });
  static const String id = 'products';

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String _value;
  String documentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategoryName ?? ''),
        actions: <Widget>[
          DropdownButton(
            hint: Container(
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
            items: [
              DropdownMenuItem(
                value: "1",
                child: Text("Новый продукт"),
              ),
              DropdownMenuItem(
                value: "2",
                child: Text("Новый цвет"),
              ),
              DropdownMenuItem(
                value: "3",
                child: Text("Новый размер"),
              )
            ],
            onChanged: (value) {
              setState(
                () {
                  if (value == '1') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddProduct(
                              categoryAlemId: widget.categoryAlemId,
                              subId: widget.subId,
                            )));
                  } else if (value == '2') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddColor()));
                  } else
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddSize(
                              subCategoryId: widget.subId,
                            )));
                },
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          final products = snapshot.data.docs.reversed;
          List<ProductItem> productList = [];
          for (var item in products) {
            final name = item.data()['name'];
            final picture = item.data()['url'];
            final subCategoryId = item.data()['subcategory'];
            final documentId = item.data()['documentId'];
            final productItem = ProductItem(
              documentId: documentId,
              picture: picture,
              name: name,
            );
            if (widget.subId == subCategoryId) {
              productList.add(productItem);
            }
          }
          return GridView(
            children: productList,
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
        },
      ),
    );
  }
}
