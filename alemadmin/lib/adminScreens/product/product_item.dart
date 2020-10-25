import 'package:alemadmin/adminScreens/product/products_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance.collection('products');

class ProductItem extends StatelessWidget {
  final String name;
  final String picture;
  final String documentId;

  ProductItem({
    this.name,
    this.picture,
    this.documentId,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
                content: Text('Вы хотите удалить?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('НЕТ'),
                  ),
                  FlatButton(
                    onPressed: () {
                      _firestore.doc(documentId).delete();
                      Navigator.pop(context);
                    },
                    child: Text('Удалить'),
                  ),
                ]),
          );
        },
        child: GridTile(
          child: Image.network(picture),
          footer: GridTileBar(
            // leading: IconButton(
            //   icon: Icon(Icons.favorite),
            //   onPressed: () {},
            // ),
            backgroundColor: Colors.black45,
            title: Text(
              name,
              textAlign: TextAlign.center,
            ),
            // trailing: IconButton(
            //   icon: Icon(Icons.add_shopping_cart),
            //   onPressed: () {},
            // ),
          ),
        ),
      ),
    );
  }
}
