import 'package:alemadmin/adminScreens/successful.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddSize extends StatefulWidget {
  final int subCategoryId;
  AddSize({this.subCategoryId});

  @override
  _AddSizeState createState() => _AddSizeState();
}

class _AddSizeState extends State<AddSize> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить новый размер')),
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
                    labelText: 'Название размера'),
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
              elevation: 8,
              color: Colors.greenAccent[700],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              onPressed: () => {
                if (_formkey.currentState.validate())
                  {
                    FirebaseFirestore.instance.collection('size').add({
                      'subcategory': widget.subCategoryId,
                      'name': name,
                    }),
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Successfull())),
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
