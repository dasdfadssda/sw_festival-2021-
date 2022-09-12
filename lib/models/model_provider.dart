// models/model_item_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sw_festival/models/model.dart';

// class ContentsProvider with ChangeNotifier { //contents를 provider로 설정해준다. 
//   late CollectionReference itemsReference;
//   var contents = [];
// //  List<Contents> contents = [];  // 이렇게 하면 String이 아니라서 null 
//   ContentsProvider({reference}) {
//     itemsReference = reference ?? FirebaseFirestore.instance.collection('contents');
//   }

//   Future<void> ContentsListMake() async { // contents를 파이어베이스에서 가져와서 읽기 
//     contents = await itemsReference.get().then((QuerySnapshot results) {
//       return results.docs.map( (DocumentSnapshot document) {
//         return Contents.fromSnapshot(document);
//       }).toList();
//     });
//     notifyListeners();
//   }
// }

class ItemProvider with ChangeNotifier {
  late CollectionReference itemsReference;
  List<Post> items = [];

  ItemProvider({reference}) {
    itemsReference = reference ?? FirebaseFirestore.instance.collection('contents');
  }

  Future<void> fetchItems() async {
    items = await itemsReference.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return Post.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }
}
