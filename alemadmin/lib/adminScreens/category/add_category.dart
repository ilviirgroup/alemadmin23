import 'dart:io';
import 'dart:math';

import 'package:alemadmin/adminScreens/successful.dart';
import 'package:alemadmin/adminScreens/product/add_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddCategory extends StatefulWidget {
  static const String id = "add_category";
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  int id = 0;
  String name = '';
  String imageUrl;
  String alemid = '';
  String documentId;
  DocumentReference docRef;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('lastids')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) {
                id = doc.data()['category'];
              })
            });
    return Scaffold(
      appBar: AppBar(title: Text("Добавить категорию")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            RaisedButton(
              child: Text(
                'Загрузить изображение',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightBlue,
              onPressed: () => uploadImage(),
            ),
            SizedBox(height: 20.0),
            (imageUrl != null)
                ? Image.network(imageUrl)
                : Placeholder(
                    fallbackHeight: 200.0, fallbackWidth: double.infinity),
            SizedBox(height: 20.0),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Необходимые';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Название категории',
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Необходимые";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:
                            'AlemId напр.: wom, man, kid, mob, shoe, elec',
                      ),
                      onChanged: (value) {
                        alemid = value;
                      },
                    ),
                  ),
                ],
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
                          .collection('lastids')
                          .doc('lastIds')
                          .update({'category': (id + 1)}),
                      docRef = FirebaseFirestore.instance
                          .collection('category')
                          .doc(),
                      docRef.set({
                        'documentId': docRef.id,
                        'id': (id + 1),
                        'alemid': alemid,
                        'name': name,
                        'url': imageUrl,
                      }),
                      Navigator.pop(context),
                      Fluttertoast.showToast(msg: 'Категория добавлена'),
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => Successfull())),
                    }
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                label: Text(
                  "Добавить",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        var snapshot = await _storage
            .ref()
            .child('category')
            .child('${id + 1}.jpg')
            .putFile(file)
            .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        return ('No path received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
