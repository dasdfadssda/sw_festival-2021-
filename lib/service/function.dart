//  import 'package:flutter/material.dart';

// import '../HomePage.dart';

// Future<void> _showMyDialog() async {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//          title: const Text('나가시겠습니까?',style: TextStyle(fontWeight: FontWeight.bold),),
//          content: const Text('지금 나가시면 \n글이 저장되지 않습니다.'),
//         actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'Cancel'),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () =>  Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => HomePage()),
//           ),
//               child: const Text('OK'),
//             ),
//           ],
//       );
//     },
//   );
// }

