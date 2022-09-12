import 'package:cloud_firestore/cloud_firestore.dart';

class Post { //파이어 스토에서 정보 읽기 위해 가져오기 
  late String contents;
  late String datetime;
  late String displayName;
  late String id;
  late String imageUrl;
  late String title;

  Post({
    required this.contents,
    required this.datetime,
    required this.displayName,
    required this.id,
    required this.imageUrl,
    required this.title,
  });
  
  Post.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    contents = data['contents'];
    datetime = data['datetime'];
    displayName = data['displayName'];
    id = data['id'];
    imageUrl = data['imageUrl'];
    title = data['title'];
  }
}


