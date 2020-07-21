// import 'package:SnapLoop/Screens/Home/Bitmojis/bitmoji.dart';
// import 'package:flutter/material.dart';

// class MemojiTest extends StatelessWidget {
//   const MemojiTest({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Center(
//         child: ListView.builder(
//           itemBuilder: (context, index) {
//             return Container(
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                       child: Image(
//                           image: NetworkImage(
//                               URLMemojis[index].replaceAll("%s", USERS[0]))),
//                     ),
//                   ),
//                   Text(
//                     "${index + 1}",
//                     style: TextStyle(fontSize: 25),
//                   )
//                 ],
//               ),
//             );
//           },
//           itemCount: URLMemojis.length,
//         ),
//       )),
//     );
//   }
// }
