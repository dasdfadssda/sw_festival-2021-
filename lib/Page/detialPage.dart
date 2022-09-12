import 'package:flutter/material.dart';
import 'package:sw_festival/models/model.dart';

class DetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Post;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Container(
        child: ListView(
          children: [
            Image.network(item.imageUrl),
            Padding(padding: EdgeInsets.all(4)),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        Text(
                          'add cart',
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(item.contents, style: TextStyle(fontSize: 16),),
            )
          ],
        ),
      ),
    );
  }
}