import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SelectColor extends StatefulWidget {
  final selectedAnimals;
  SelectColor({this.selectedAnimals});

  @override
  _SelectColorState createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('color').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            );
          }
          final colors = snapshot.data.docs.reversed;
          List _animals = [];
          for (var item in colors) {
            final name = item.data()['name'];
            _animals.add(name);
          }
          final _items = _animals
              .map((animal) => MultiSelectItem(animal, animal))
              .toList();

          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: MultiSelectDialogField(
              searchable: true,
              items: _items,
              title: Text("Animals"),
              selectedColor: Colors.blue,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
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
                "Select Colors",
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 16,
                ),
              ),
              onConfirm: (results) {
                results = widget.selectedAnimals;
              },
            ),
          );
        },
      ),
    );
  }
}
