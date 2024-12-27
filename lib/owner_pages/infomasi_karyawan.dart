// import 'package:butter_app_project/data%20base/data_karyawan.dart';
// import 'package:butter_app_project/data%20base/model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:butter_app_project/data base/data_karyawan.dart';
// import 'package:butter_app_project/data base/model.dart';
//
// class DaftarKaryawan extends StatefulWidget {
//   const DaftarKaryawan({super.key});
//
//   @override
//   State<DaftarKaryawan> createState() => _DaftarKaryawanState();
// }
//
// class _DaftarKaryawanState extends State<DaftarKaryawan> {
//   KaryawanDB karyawan = KaryawanDB();
//   Future<List<MdKaryawan>>? futureKaryawan;
//
//   @override
//   void initState() {
//     super.initState();
//     futureKaryawan = karyawan.readKaryawan();
//   }
//   var data;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//         FutureBuilder<List<MdKaryawan>>(
//           future: futureKaryawan,
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
//               List<MdKaryawan> kry = snapshot.data! ;
//               return
//                 ListView.builder(
//                     itemCount: kry.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: (){
//                           showDialog(context: context,
//                               builder: (BuildContext  context){
//                             return AlertDialog(
//                               content: Container(
//                                 width: 300,
//                                 height: 200,
//                                 child: Column(
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 40,
//                                       child: Icon(Icons.person, size: 30),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text("Username : ${kry[index].nama}"),
//                                     SizedBox(height: 10),
//                                     Text("Email : ${kry[index].email}"),
//                                     SizedBox(height: 10),
//                                     Text("No Telepon : ${kry[index].no_telp.toString()}"),
//                                   ],
//                                 ),
//                               ),
//                             );
//                               });
//                         },
//                         child: Card(
//                           child: ListTile(
//                             trailing: SizedBox(
//                               width: 100,
//                               child:
//                                   IconButton(
//                                     onPressed: () {
//                                       karyawan.delete(kry[index].id!);
//                                       setState(() {
//                                         futureKaryawan = karyawan.readKaryawan();
//                                       });
//                                     },
//                                     icon: const Icon(
//                                       Icons.delete,
//                                       size: 16,
//                                     ),
//                                     color: Colors.red,
//                                   )
//                             ),
//                             title: Text(kry[index].nama),
//                             subtitle: Text(kry[index].email),
//                             // leading: CircleAvatar(child: Text(kry[index].)),
//                           ),
//                         ),
//                       );
//                     });
//             }
//           },
//         ));
//   }
// }
