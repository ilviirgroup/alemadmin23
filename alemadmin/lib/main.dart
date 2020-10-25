import 'package:alemadmin/adminScreens/admin_home.dart';
import 'package:alemadmin/adminScreens/app_messages.dart';
import 'package:alemadmin/adminScreens/app_users.dart';
import 'package:alemadmin/adminScreens/login_screen.dart';
import 'package:alemadmin/adminScreens/orders/orders.dart';
import 'package:alemadmin/adminScreens/product/add_more_images.dart';
import 'package:alemadmin/adminScreens/product/add_product.dart';
import 'package:alemadmin/adminScreens/product/products_screen.dart';
import 'package:alemadmin/adminScreens/subCategory/add_sub_category.dart';
import 'package:alemadmin/adminScreens/subCategory/subCategories_screen.dart';
import 'package:alemadmin/adminScreens/order_history.dart';
import 'package:alemadmin/adminScreens/privilages.dart';
import 'package:alemadmin/adminScreens/search_data.dart';
import 'package:alemadmin/adminScreens/subCategory/update_sub_category.dart';
import 'package:alemadmin/adminScreens/successful.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'adminScreens/category/add_category.dart';
import 'adminScreens/category/categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Firebase.initializeApp();
    return MaterialApp(
      title: 'Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      routes: {
        AdminHome.id: (context) => AdminHome(),
        AppMessages.id: (context) => AppMessages(),
        Categories.id: (context) => Categories(),
        AppUsers.id: (context) => AppUsers(),
        OrderHistory.id: (context) => OrderHistory(),
        Privilages.id: (context) => Privilages(),
        SearchData.id: (context) => SearchData(),
        LoginScreen.id: (context) => LoginScreen(),
        AddCategory.id: (context) => AddCategory(),
        SubCategories.id: (context) => SubCategories(),
        Products.id: (context) => Products(),
        AddSubCategory.id: (context) => AddSubCategory(),
        AddProduct.id: (context) => AddProduct(),
        Orders.id: (context) => Orders(),
        Successfull.id: (context) => Successfull(),
        UpdateSubCategory.id: (context) => UpdateSubCategory(),
      },
    );
  }
}
