import 'package:alemadmin/adminScreens/category/categories_screen.dart';
import 'package:alemadmin/adminScreens/orders/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_products.dart';
import 'app_messages.dart';
import 'app_users.dart';
import 'order_history.dart';
import 'privilages.dart';
import 'search_data.dart';

class AdminHome extends StatefulWidget {
  static const String id = 'admin_home';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('App Admin'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            //MainScreen(),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => SearchData()));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.search),
                        SizedBox(height: 10.0),
                        Text('Поиск' //'Search Data',
                            ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => AppUsers()));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(height: 10.0),
                        Text('Пользователи'),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => Orders()));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.notifications),
                        SizedBox(height: 10.0),
                        Text('Заказы'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => AppMessages()));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.chat),
                        SizedBox(height: 10.0),
                        Text('Сообщения'),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => Categories()));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.shop),
                        SizedBox(height: 10.0),
                        Text('Категории'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => AddProducts()));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add),
                        SizedBox(height: 10.0),
                        Text('Add Products'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => OrderHistory()));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.history),
                        SizedBox(height: 10.0),
                        Text('Order History'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => Privilages()));
                  },
                  child: CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(height: 10.0),
                        Text('Privilages'),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*
StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('subcategory').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final categories = snapshot.data.docs.reversed;
                List<GestureDetector> subCategoryList = [];
                for (var categoryId in categories) {
                  final category = categoryId.data()['category'];
                  final name = categoryId.data()['name'];
                  final id = categoryId.data()['id'];

                  if(category==widget.subcategory) {
                    if(subId==null){
                      subId=id;
                    }
                    final categoryitem = subcategoryButton(name: name,id: id);
                    subCategoryList.add(categoryitem);
                  }

                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                          height: 30,
                          child: ListView.builder(
                            itemCount: subCategoryList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,i)=>subCategoryList[i],
                          )

                      ),
                    ),
                    Expanded(child: SubCategoryGridView(subId: subId,))
                  ],

                );
              },
            ),
*/
