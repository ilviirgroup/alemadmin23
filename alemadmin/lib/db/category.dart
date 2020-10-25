// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';

// class CategoryService {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void createCategory(String name) {
//     // _firestore.collection('category').add({"data": "dsklf"});
//     var id = Uuid();

//     String categoryId = id.v1();
//     if (name != '') {
//       _firestore.collection('category').doc(categoryId).set({'name': name});
//     }
//   }
// }
