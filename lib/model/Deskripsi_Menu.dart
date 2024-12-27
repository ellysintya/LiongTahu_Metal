// import 'package:flutter/material.dart';
//
// class DetailMenu extends StatefulWidget {
//   const DetailMenu({super.key});
//
//   @override
//   State<DetailMenu> createState() => _DetailMenuState();
// }
//
// class _DetailMenuState extends State<DetailMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showModalBottomSheet(context: context,
//             enableDrag: true,
//             isScrollControlled: true,
//             builder: (BuildContext context) {
//               return Container(
//                 padding: EdgeInsets.all(20),
//                 height: 800,
//                 width: MediaQuery
//                     .of(context)
//                     .size
//                     .width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment
//                       .start,
//                   mainAxisAlignment: MainAxisAlignment
//                       .end,
//                   children: [
//                     Image(image: MemoryImage(imageBytes)),
//
//                     SizedBox(height: 20,),
//                     Text(mn["nama"], style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),),
//                     Text(mn["deskripsi"],
//                       style: TextStyle(fontSize: 15,
//                           color: Colors.grey
//                               .shade400),),
//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment
//                           .spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             ElevatedButton(
//                               onPressed: _DecrementCounter,
//                               child: Icon(Icons.remove,
//                                 color: Colors.black,),
//                               style: ElevatedButton
//                                   .styleFrom(
//                                 shape: CircleBorder(
//                                     side: BorderSide(
//                                         color: Color(
//                                             0xffB8001F),
//                                         width: 2)
//                                 ),
//                               ),),
//                             Text('$jlh'),
//
//                             ElevatedButton(
//                                 onPressed: _incrementCounter,
//                                 child: Icon(Icons.add,
//                                   color: Colors.black,),
//                                 style: ElevatedButton
//                                     .styleFrom(
//                                     shape: CircleBorder(
//                                         side: BorderSide(
//                                             color: Color(
//                                                 0xff47663B),
//                                             width: 2)
//                                     ))
//                             ),
//                           ],
//                         ),
//                         Text(mn["harga"],
//                             style: TextStyle(
//                                 color: Color(
//                                     0xff47663B),
//                                 fontWeight: FontWeight
//                                     .bold,
//                                 fontSize: 15)
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 100,),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment
//                           .center,
//                       mainAxisAlignment: MainAxisAlignment
//                           .spaceBetween,
//                       children: [
//                         Text(jlh > 0 ? "Rp.${int.parse(
//                             mn["harga"]) * jlh}" : "",
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight
//                                     .bold,
//                                 color: Color(
//                                     0xff47663B))),
//                         ElevatedButton(onPressed: () {
//                           selectedImage = base64Decode(mn["foto_menu"]);
//                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dashboard(imageBytes: selectedImage, harga: totalPrice ,jlh: jlh, nama: mn["nama"],),));
//                           jlh = 0;
//                         },
//                           child: Text(
//                               jlh > 0 ? "Order" : "",
//                               style: TextStyle(
//                                 color: Colors.white,)),
//                           style: ElevatedButton
//                               .styleFrom(
//                               backgroundColor: jlh > 0
//                                   ? Color(0xff47663B)
//                                   : null,
//                               shape: ContinuousRectangleBorder(),
//                               minimumSize: Size(
//                                   MediaQuery
//                                       .of(context)
//                                       .size
//                                       .width / 2, 50)
//                           ),),
//                       ],
//                     )
//                   ],
//                 ),
//               );
//             });
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.memory(
//               imageBytes,
//               fit: BoxFit.cover
//               ,
//               height: 100,
//               width: 100,
//             ),
//           ),
//           SizedBox(height: 20,),
//           Text(mn["nama"], style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold),),
//           SizedBox(height: 5),
//           Text("Rp ${mn["harga"]}", style: TextStyle(
//               color: Color(0xff47663B), fontSize: 12),)
//         ],
//       ),
//     ),;
//   }
// }
//
//
