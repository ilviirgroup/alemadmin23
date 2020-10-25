import 'package:alemadmin/adminScreens/successful.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddSubCategory extends StatefulWidget {
  final int categoryId;
  AddSubCategory({this.categoryId});
  static const String id = 'add_sub_category';

  @override
  _AddSubCategoryState createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String alemid;
  String name;
  int id;
  DocumentReference docRef;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('lastids')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) {
                id = doc.data()['subcategory'];
              })
            });
    return Scaffold(
      appBar: AppBar(title: Text('Добавить подкатегорию')),
      body: Column(
        children: <Widget>[
          Form(
            key: _formkey,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Необходимые";
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название подкатегории'),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: RaisedButton.icon(
              color: Colors.greenAccent[700],
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              onPressed: () => {
                if (_formkey.currentState.validate())
                  {
                    FirebaseFirestore.instance
                        .collection('lastids')
                        .doc('lastIds')
                        .update({'subcategory': (id + 1)}),
                    docRef = FirebaseFirestore.instance
                        .collection('subcategory')
                        .doc(),
                    docRef.set({
                      'documentId': docRef.id,
                      'category': widget.categoryId,
                      'id': (id + 1),
                      'name': name,
                    }),
                    Navigator.pop(context),
                    Fluttertoast.showToast(msg: 'Подкатегория добавлена'),

                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Successfull())),
                  }
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              label: Text(
                "Добавить",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
