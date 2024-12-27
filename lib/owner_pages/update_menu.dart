// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:butter_app_project/model/menu_model.dart';
// import 'package:butter_app_project/data base/data_menu.dart';
// import 'package:butter_app_project/owner_pages/menu.dart';
//
//
// class UpdateMenu extends StatefulWidget {
//   final MenuModel menu ;
//   const UpdateMenu ({super.key , required this.menu});
//
//   @override
//   State<UpdateMenu> createState() => _UpdateMenuState();
// }
//
// class _UpdateMenuState extends State<UpdateMenu> {
//   final _fromKey = GlobalKey<FormState>();
//   late TextEditingController nama_menu ;
//   late TextEditingController harga ;
//   late TextEditingController foto  ;
//   late TextEditingController desc ;
//
//   @override
//   void initState() {
//     super.initState();
//     nama_menu = TextEditingController(text: widget.menu.namaMenu);
//     harga = TextEditingController(text: widget.menu.harga) ;
//     foto = TextEditingController(text: widget.menu.foto) ;
//     desc = TextEditingController(text: widget.menu.desc);
//   }
//
//   @override
//   void dispose() {
//     nama_menu.dispose();
//     harga.dispose();
//     foto.dispose();
//     desc.dispose();
//     super.dispose();
//   }
//
//   MenuDB menuDB = MenuDB();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Menu"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: double.infinity,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(
//                   height: 60,
//                 ),
//                 SizedBox(
//                   height: 40,
//                   child: TextField(
//                     controller: nama_menu,
//                     decoration: InputDecoration(
//                       // hintText: "Nomor Induk Mahasiswa",
//                       border: OutlineInputBorder(),
//                       contentPadding:
//                       EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 32,
//                 ),
//                 SizedBox(
//                   height: 40,
//                   child: TextField(
//                     controller: harga,
//
//                     decoration: InputDecoration(
//                       // hintText: "Nama Mahasiswa",
//                       border: OutlineInputBorder(),
//                       contentPadding:
//                       EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 32,
//                 ),
//                 SizedBox(
//                   height: 40,
//                   child: TextField(
//                     controller: foto,
//                     decoration: InputDecoration(
//                       // hintText: "Nama Mahasiswa",
//                       border: OutlineInputBorder(),
//                       contentPadding:
//                       EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 32,
//                 ),
//                 SizedBox(
//                   height: 40,
//                   child: TextField(
//                     controller: desc,
//                     decoration: InputDecoration(
//                       // hintText: "Nama Mahasiswa",
//                       border: OutlineInputBorder(),
//                       contentPadding:
//                       EdgeInsets.symmetric(vertical: 0, horizontal: 8),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(
//                   height: 32,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       menuDB.update(MenuModel(
//                           id: widget.menu.id,
//                           harga: harga.text,
//                           namaMenu: nama_menu.text,
//                           foto: foto.text,
//                       desc: desc.text));
//                     });
//                     Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(builder: (context) => const Menu()),
//                             (Route<dynamic> route) => false);
//                   },
//                   child: const Text("SAVE" , style: TextStyle(color: Colors.white),),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF850000)
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
