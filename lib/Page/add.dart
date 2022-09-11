
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sw_festival/Auth/auth_service.dart';
import 'package:sw_festival/HomePage.dart';


class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   File? _photo;
   final ImagePicker _picker = ImagePicker();



// 사진 가져오기
  Future imgFromGallery() async {
    final image = await _picker.pickImage(
        source: ImageSource.gallery);
        if(image == null) return;
        final imagePhoto = File(image.path);
    setState(() {
     this._photo = imagePhoto;
    });
    
  }
// 카메라에서 가져오기
    Future imgFromCamera() async {
    final image = await _picker.pickImage(
        source: ImageSource.camera);
        if(image == null) return;
        final imagePhoto = File(image.path);
    setState(() {
     this._photo = imagePhoto;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: () => _showMyDialog(),
         icon: Icon(Icons.arrow_back, color: Colors.black),
      ), // leading
      title: Text("작성하기", style: TextStyle(color: Colors.black),),
      actions: [
        TextButton(
              onPressed: () async{
                contentsFunction(FirebaseAuth.instance.currentUser!.displayName!,_photo,TitleController,contentsController);
             Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()),
          );
              },
              child: Text('공유',style: TextStyle(color: Color(0xff4262A0)),))
      ],
    ),
        body: Column(children: [
          Container(
            child: _photo != null ? Image.file(_photo!,height: 300, width: double.infinity,) : _CameraButton(),
            decoration: BoxDecoration(border: Border.all(width: 2)),
          ), // 카메라 사진 혹은 내가 올릴 사진
          Divider(height: 1,color: Colors.black,),
          TitleText(),
          ContentsText()
        ],)
    );
  }


      Widget _CameraButton() { // 사진 추가 버튼 
    return  InkWell(
                onTap: () {
               _showPicker(context);
                },
        child: Container(
          decoration: BoxDecoration(
       border: Border.all( 
         width: 1,
         color: Colors.blueAccent, 
      ),),
          height: 300,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.camera_alt_rounded, color: Color(0xff4262A0), size: 100,),
               SizedBox(height: 10,),
               Text("사진 추가하기", style: TextStyle(color: Color(0xff4262A0)),)
          ],),
        ),
    );
  }
  final TitleController = TextEditingController();
  final contentsController = TextEditingController();

  Widget TitleText() { // 글 제목
    return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10, right: 200),
            child: TextFormField(
               maxLines: 3,
               minLines: 1,
              controller: TitleController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
                hintText: '글 제목',
              ),
            ),
          );
  }

  Widget ContentsText() { // 글 내용
    return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
            child: TextFormField(
                maxLines: 5,
               minLines: 1,
              controller: contentsController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
                hintText: '글 내용',
              ),
            ),
          );
  }

   Widget HashTagClip() { // 생각해봐야함
    return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10, right: 10),
            child: TextFormField(
                maxLines: 5,
               minLines: 1,
              controller: contentsController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4262A0))),
                border: OutlineInputBorder(),
                hintText: '글 내용',
              ),
            ),
          );
  }
  
// snapBar 기능
    void _showPicker(context) { 
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
// 나가기 기능 
 Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
         title: const Text('나가시겠습니까?',style: TextStyle(fontWeight: FontWeight.bold),),
         content: const Text('지금 나가시면 \n글이 저장되지 않습니다.'),
        actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                 Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()),
          );
           TitleController.clear();
           contentsController.clear();
              }, 
              child: const Text('OK'),
            ),
          ],
      );
    },
  );
}


}

