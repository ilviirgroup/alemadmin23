import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateSubCategory extends StatefulWidget {
  static const String id = 'updateSubCategory';
  final String documentId;
  final String name;
  UpdateSubCategory({this.documentId, this.name});
  @override
  _UpdateSubCategoryState createState() => _UpdateSubCategoryState();
}

class _UpdateSubCategoryState extends State<UpdateSubCategory> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  String updatedName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Обновить подкатегорию')),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _textEditingController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Необходимые';
                  }
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название подкатегории'),
                onChanged: (value) {
                  updatedName = value;
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
                if (_formKey.currentState.validate())
                  {
                    FirebaseFirestore.instance
                        .collection('subcategory')
                        .doc(widget.documentId)
                        .update({'name': updatedName}),
                    Navigator.pop(context),
                    Fluttertoast.showToast(msg: 'Подкатегория обновлена'),

                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Successfull())),
                  }
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              label: Text(
                "Обновить",
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
