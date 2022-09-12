import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_festival/Page/add.dart';
import 'package:sw_festival/models/model_provider.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final contentsProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPage()),
          );
        },
        label: const Text('글 쓰기',style: TextStyle(fontWeight: FontWeight.bold),),
        icon: const Icon(Icons.add,size: 25,),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(  // 화면 만들기! 
      future: contentsProvider.fetchItems(),
      builder: (context, snapshots) {
        if (contentsProvider.items.length == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
              ), 
              itemCount: contentsProvider.items.length,
              itemBuilder: (context, index) {
                return GridTile(
                    child: InkWell(
                      onTap: () {
                         Navigator.pushNamed(context, '/detail',
                            arguments: contentsProvider.items[index]);
                            print('detail 페이지로 이동');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(contentsProvider.items[index].imageUrl),
                            Text(
                              contentsProvider.items[index].title,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(contentsProvider.items[index].contents.toString() + '원',
                            style: TextStyle(fontSize: 16, color: Colors.red),)
                          ],
                        ),
                      ),
                    )
                );
              }
          );
        }
      },
    )
    );
  }


}