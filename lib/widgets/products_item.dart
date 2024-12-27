// import 'package:flutter/material.dart';
// import 'package:butter_app_project/model/Deskripsi_Menu.dart';
//
// class ProductItem extends StatelessWidget {
//   final ProductsModel product;
//
//   const ProductItem({Key? key, required this.product}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               product.name,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 5),
//             Text(
//               'Rp ${product.price.toStringAsFixed(0)}', // Display price
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () => _showAddToCartPopup(context),
//               child: Text("Add to Cart"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddToCartPopup(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         int quantity = 1;
//         return AlertDialog(
//           title: Text("Order ${product.name}"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("Quantity"),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.remove),
//                     onPressed: () {
//                       if (quantity > 1) {
//                         quantity--;
//                       }
//                     },
//                   ),
//                   Text(quantity.toString()),
//                   IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: () {
//                       quantity++;
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Order"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
