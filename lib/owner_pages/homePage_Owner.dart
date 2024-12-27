//
// import 'package:butter_app_project/authentication/welcome.dart';
// import 'package:butter_app_project/owner_pages/infomasi_karyawan.dart';
// import 'package:butter_app_project/owner_pages/menu.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Front extends StatefulWidget {
//   const Front({super.key});
//
//   @override
//   State<Front> createState() => _FrontState();
// }
//
// class _FrontState extends State<Front> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   int current = 0;
//   Widget bodyPage(int index) {
//     if (index == 0) {
//       return Menu();
//     } else {
//       return DaftarKaryawan();
//     }
//   }
//   void Logout(BuildContext context) async{
//     await auth.signOut();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("Logged Out"),
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 2), // Durasi tampil snackbar
//       ),
//     );
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Choice(),));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final myPost = Provider.of<PostingProvider>(context).myProfile;
//     return Scaffold(
//       body: bodyPage(current),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.book),
//               label: 'Menu',
//               activeIcon: Icon(Icons.book)),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.h_mobiledata_sharp),
//             label: "Cashier",
//           ),
//           BottomNavigationBarItem(icon: PopupMenuButton(
//             icon: Icon(Icons.person_4_rounded),
//               onSelected: (value){
//               if(value == "logout"){
//                 Logout(context);}
//               },
//               itemBuilder: (BuildContext context) => [
//                 PopupMenuItem(
//                   value : "logout",
//                     child: Text("Logout"))
//               ]), label: 'owner',
//           ),
//         ],
//         backgroundColor: Color(0xff850000),
//         // selectedFontSize: double.maxFinite,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//         currentIndex: current,
//         onTap: (int index) {
//           setState(() {
//             current = index;
//           });
//         },
//       ),
//     );
//   }
// }
//
//
