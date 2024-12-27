// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:butter_app_project/data base/data_menu.dart';
// import 'package:butter_app_project/model/menu_model.dart';
// import 'package:butter_app_project/owner_pages/add_menu.dart';
// import 'package:butter_app_project/owner_pages/update_menu.dart';
//
//
// class Menu extends StatefulWidget {
//   const Menu({super.key});
//
//   @override
//   State<Menu> createState() => _MenuState();
// }
//
// class _MenuState extends State<Menu> {
//   final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//
//   MenuDB menu = MenuDB();
//   Future<List<MenuModel>>? futureMenu;
//
//   @override
//   void initState() {
//     super.initState();
//     futureMenu = menu.read();
//   }
//   var data;
//
//   Future<void> _logEvent(String eventName, {Map<String, Object>? parameters}) async {
//     await analytics.logEvent(
//       name: eventName,
//       parameters: parameters,
//     );
//   }
//
//   Future<void> _confirmDelete(int id) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Konfirmasi Hapus'),
//         content: const Text('Apakah Anda yakin ingin menghapus item ini?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Batal'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Hapus'),
//           ),
//         ],
//       ),
//     );
//
//     if (confirmed == true) {
//       menu.delete(id);
//       setState(() {
//         futureMenu = menu.read();
//       });
//       await _logEvent('delete_menu_item', parameters: {'menu_id': id});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Metal Menu"),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return AddMenu();
//                       },
//                     ),
//                   );
//                   _logEvent('add_menu_item'); // Log the event when adding a menu
//                 },
//                 icon: const Icon(Icons.bookmark_add_outlined))
//           ],
//         ),
//         body:
//         FutureBuilder<List<MenuModel>>(
//           future: futureMenu,
//           builder: (context ,snapshot){
//             if (snapshot.connectionState == ConnectionState.waiting){
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             else if (snapshot.hasError){
//               return Center(
//                 child: Text("Error : ${snapshot.error}"),
//               );
//             }
//             else if (!snapshot.hasData || snapshot.data!.isEmpty){
//               return Center(
//                 child: Text("tidak ada data"),
//               );
//             }
//             else {
//               List<MenuModel> menus = snapshot.data! ;
//               return
//                 GridView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                   childAspectRatio: 0.9),
//                     itemCount: menus.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         // padding: EdgeInsets.all(20),
//                         // margin: EdgeInsets.all(20),
//                         child: Card(
//                           child: Column(
//                             children: [
//                               SizedBox(height: 30),
//                               Image(image: NetworkImage(menus[index].foto), width: 100),
//                               SizedBox(height: 10),
//                               Text(menus[index].namaMenu),
//                               SizedBox(height: 10),
//                               Text("Rp ${menus[index].harga}"),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     IconButton(
//                                       onPressed: () {
//                                         Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                             builder: (context) {
//                                               return UpdateMenu(menu : menus[index]);
//                                             },
//                                           ),
//                                         );
//                                         _logEvent('edit_menu_item', parameters: {'menu_id': menus[index].id!});
//                                       },
//                                       icon: const Icon(
//                                         Icons.edit,
//                                         size: 16,
//                                       ),
//                                       color: Colors.blue,
//                                     ),
//                                     IconButton(
//                                       onPressed: () => _confirmDelete(menus[index].id!),
//
//                                       icon: const Icon(
//                                         Icons.delete,
//                                         size: 16,
//                                       ),
//                                       color: Colors.red,
//                                     )
//                                   ],
//                                 ),
//                             ],
//                           ),
//                         ),
//                       );
//                     });
//             }
//           },
//         ));
//   }
// }
