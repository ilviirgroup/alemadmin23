import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance.collection('orders').snapshots();

class Orders extends StatefulWidget {
  static const String id = 'orders';
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool check;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Заказы'),
        ),
        backgroundColor: Colors.amber,
        body: StreamBuilder(
            stream: _firestore,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot orders = snapshot.data.documents[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Имя: ${orders.data()['name']}",
                                style: TextStyle(fontSize: 20)),
                            Text("AlemId: ${orders.data()['alemid']}",
                                style: TextStyle(fontSize: 16)),
                            Text(
                                "Количество: ${orders.data()['quantity'].toString()}",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              child: Divider(color: Colors.amber.shade100),
                            ),
                            Text(orders.data()['date'] != null
                                ? orders.data()['date']
                                : ''),
                            Text(orders.data()['user'],
                                style: TextStyle(fontSize: 16)),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: orders.data()['completed'] == true
                                      ? orders.data()['completed']
                                      : false,
                                  onChanged: (bool value) {
                                    setState(() {
                                      check = value;
                                    });
                                  },
                                ),
                                Text('Завершено'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }
}
