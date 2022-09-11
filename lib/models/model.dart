import 'package:cloud_firestore/cloud_firestore.dart';

class Contents { //파이어 스토에서 정보 읽기 위해 가져오기 
  late String id;
  late String title;
  late String datetime;
  late String displayName;
  late String contents;
  late String imageUrl;

  Contents({
    required this.id,
    required this.title,
    required this.datetime,
    required this.displayName,
    required this.contents,
    required this.imageUrl,
  });
  
  Contents.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = data['id'];
    title = data['title'];
    datetime = data['datetime'];
    displayName = data['displayName'];
    contents = data['contents'];
    imageUrl = data['imageUrl'];
  }
}