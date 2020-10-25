import 'dart:io';

import 'package:alemadmin/adminScreens/product/add_more_images.dart';
import 'package:alemadmin/adminScreens/product/products_screen.dart';
import 'package:alemadmin/adminScreens/product/selectColor.dart';
import 'package:alemadmin/adminScreens/successful.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProduct extends StatefulWidget {
  static const String id = 'add_products';
  final int subId;
  final String categoryAlemId;
  AddProduct({this.subId, this.categoryAlemId});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fieldName = TextEditingController();
  final fieldPrice = TextEditingController();

  File _image;
  final picker = ImagePicker();
  int pictureName = 0;
  int productNumber = 0;
  String imageUrl;
  String name;
  String alemid;
  int price;
  String status;
  String description;
  List selectedColors = [];
  List selectedSize = [];
  DocumentReference docRef;

  _addImage() async {
    final theImage = await picker.getImage(source: ImageSource.gallery);
    if (theImage != null) {
      setState(() {
        _image = File(theImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('lastids')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) {
                pictureName = doc.data()['pictures'];
                productNumber = doc.data()['products'];
              })
            });

    return Scaffold(
        appBar: AppBar(
          title: Text("Добавить товар"),
          centerTitle: false,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton.icon(
                color: Colors.greenAccent[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                onPressed: () {},
                icon: Icon(Icons.add_photo_alternate, color: Colors.white),
                label:
                    Text('Изображений', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
// ---------------------------------- Image box
          FittedBox(
            fit: BoxFit.cover,
            child: _image == null
                ? Center(
                    child:
                        Icon(Icons.photo, color: Colors.blueAccent, size: 50),
                  )
                : Image.file(_image),
          ),
          SizedBox(height: 10.0),
// ---------------------------------- Add Image Button
          RaisedButton(
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            onPressed: () {
              _addImage();
            },
            child: Text(
              'Выбрать изображение',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10.0),
// ---------------------------------- Upload Image Button
          RaisedButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            onPressed: () {
              uploadImage();
              FirebaseFirestore.instance
                  .collection('lastids')
                  .doc('lastIds')
                  .update({'pictures': (pictureName + 1)});
            },
            child: Text('Загрузить изображение',
                style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
// ---------------------------------- Product Name Form
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Необходимые";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Наименование товара'),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Price Form
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Необходимые";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Цена'),
                    onChanged: (value) {
                      price = int.parse(value);
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Status Form
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Необходимые";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Статус'),
                    onChanged: (value) {
                      status = value;
                    },
                  ),
                  SizedBox(height: 8.0),
// ---------------------------------- Product Description Form
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Необходимые";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Описание'),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
// ---------------------------------- Colors StreamBuilder
                  SingleChildScrollView(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('color')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.blueAccent,
                          );
                        }
                        final colors = snapshot.data.docs.reversed;
                        List colorsList = [];
                        for (var item in colors) {
                          final name = item.data()['name'];
                          colorsList.add(name);
                        }
                        final _items = colorsList
                            .map((color) => MultiSelectItem(color, color))
                            .toList();

                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 10),
// ---------------------------------- Colors MultiSelectField
                          child: MultiSelectDialogField(
                            searchable: true,
                            items: _items,
                            title: Text("Цвета"),
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            buttonIcon: Icon(
                              Icons.color_lens,
                              color: Colors.blue,
                            ),
                            buttonText: Text(
                              "Выберите цвет",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              selectedColors = results;
                            },
                          ),
                        );
                      },
                    ),
                  ),
// ---------------------------------- Size StreamBuilder
                  SingleChildScrollView(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('size')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.blueAccent,
                          );
                        }
                        final _size = snapshot.data.docs.reversed;
                        List sizeList = [];
                        for (var item in _size) {
                          final name = item.data()['name'];
                          final subCategory = item.data()['subcategory'];
                          if (widget.subId == subCategory) {
                            sizeList.add(name);
                          }
                        }
                        final _items = sizeList
                            .map((size) => MultiSelectItem(size, size))
                            .toList();

                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 10),
// ---------------------------------- Size MultiSelectField
                          child: MultiSelectDialogField(
                            searchable: true,
                            items: _items,
                            title: Text("Размеры"),
                            selectedColor: Colors.blue,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            // buttonIcon: Icon(
                            //   Icons.format_size,
                            //   color: Colors.blue,
                            // ),
                            buttonText: Text(
                              "Выберите размер",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: 16,
                              ),
                            ),
                            onConfirm: (results) {
                              selectedSize = results;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
// ---------------------------------- Submit Button
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: RaisedButton.icon(
              elevation: 8,
              color: Colors.greenAccent[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              onPressed: () => {
                alemid = (widget.subId.toString() +
                    widget.categoryAlemId +
                    (productNumber + 1).toString()),
                // uploadImage(),
                if (_formKey.currentState.validate())
                  {
                    FirebaseFirestore.instance
                        .collection('lastids')
                        .doc('lastIds')
                        .update({'products': (productNumber + 1)}),
                    // FirebaseFirestore.instance
                    //     .collection('lastids')
                    //     .doc('lastIds')
                    //     .update({'pictures': (pictureName + 1)}),
                    docRef =
                        FirebaseFirestore.instance.collection('products').doc(),
                    docRef.set({
                      'documentId': docRef.id,
                      'alemid': alemid,
                      'name': name,
                      'price': price,
                      'description': description,
                      'status': status,
                      'subcategory': widget.subId,
                      'colors': selectedColors,
                      'size': selectedSize,
                      'url': imageUrl,
                    }),
                    Navigator.pop(context),
                    Fluttertoast.showToast(msg: 'Продукт добавлен'),

                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => Successfull())),
                  },
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Добавить', style: TextStyle(color: Colors.white)),
            ),
          ),
        ])));
  }

// Upload image to Firebase Storage
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    var file = File(_image.path);

    if (_image != null) {
      var snapshot = await _storage
          .ref()
          .child('products')
          .child('${pictureName + 1}.jpg')
          .putFile(file)
          .onComplete;

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadUrl;
      });
    } else {
      return 'No path received';
    }
  }
}
