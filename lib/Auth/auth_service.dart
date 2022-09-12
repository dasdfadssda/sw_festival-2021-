
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sw_festival/HomePage.dart';
import 'package:sw_festival/loginPage.dart';

class AuthService{
  
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(); 
        } else {
          return const LoginPage();
        }
      },
    );
  }

  void signOut() {}

  void signInWithGoogle() {}
  
}
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();

final DateTime timestamp = DateTime.now();
// final GoogleSignInAccount? gCurrentUser = googleSignIn.currentUser;

final userReference = FirebaseFirestore.instance.collection('users');
// User? currentUser;


signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // saveUserInfoFirestore();
    DocumentSnapshot documentSnapshot = await userReference.doc(googleUser.email).get();


FirebaseFirestore.instance.collection('users').doc(googleUser.id).get().then((doc) async {
  print('회원 관리');
   if (!doc.exists) {
     userReference.doc(googleUser.id).set({
       'id' : googleUser.id,
       'profileName' : googleUser.displayName,
       'url' : googleUser.photoUrl,
       'email' : googleUser.email,
       'serverAuthCode' : googleUser.serverAuthCode,
       'Timestamp' : timestamp
     }).whenComplete((){
       print('완료');
     });
   } else {
     print('이미 있는 아이디');
   }
});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  

Future<void> signOut() async { // logOut 기능
    await _auth.signOut();
    print('logOut');
  }

contentsFunction(user,_photo,TitleController,contentsController) async { //파이어 베이스 저장 (유저 이름, 사진, 제목, 글 내용 )

 // 스토리지에 먼저 사진 업로드 하는 부분.
  final firebaseStorageRef = FirebaseStorage.instance; 
  
  TaskSnapshot task = await firebaseStorageRef
  .ref() // 시작점
  .child('post') // collection 이름
  .child('${_photo} + ${FirebaseAuth.instance.currentUser!.displayName!}') // 업로드한 파일의 최종이름
  .putFile(_photo!); 
  
  if (task != null) {
    var downloadUrl = await task.ref.getDownloadURL().whenComplete(() => print('사진 만들기 성공'));  
      var doc = FirebaseFirestore.instance.collection('contents').doc(); 
      doc.set({
        'id': doc.id,
        'datetime' : DateTime.now().toString(),
        'displayName':FirebaseAuth.instance.currentUser!.displayName!,
        'title' : TitleController.text,
        'contents' : contentsController.text,
        'imageUrl' : downloadUrl
      }).whenComplete(() => print('데이터 저장 성공'));

      Map<String, dynamic> Contents = { // map 형태로 저장 
        'title' : TitleController.text,
        'contents' : contentsController.text,
        'imageUrl' : downloadUrl,
        'datetime' : DateTime.now().toString(),
        'id': doc.id,
      };
    }
}
