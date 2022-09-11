// models/model_item_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sw_festival/models/model.dart';

class ItemProvider with ChangeNotifier {
  late CollectionReference itemsReference;
  List<Contents> items = [];

  ItemProvider({reference}) {
    itemsReference = reference ?? FirebaseFirestore.instance.collection('items');
  }

  Future<void> ContentsListMake() async { // contents를 파이어베이스에서 가져와서 읽기 
    items = await itemsReference.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return Contents.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }
}