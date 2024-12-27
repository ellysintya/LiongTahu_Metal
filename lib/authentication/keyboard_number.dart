// import 'package:flutter/material.dart';
// import 'package:butter_app_project/model/save_helper.dart';
//
// class KeyboardNumber extends StatelessWidget {
//   final Function() onPressed;
//   final int number;
//   const KeyboardNumber(
//       {super.key, required this.onPressed, required this.number});
//
//   @override
//   Widget build(BuildContext context) {
//     AuthBloc bloc = context.read<AuthBloc>();
//     return StreamBuilder<AuthState>(
//         stream: bloc.controller,
//         builder: (context, snapshot) {
//           bool isLoading =
//               snapshot.data?.isLoading ?? false || !snapshot.hasData;
//           return TextButton(
//             onPressed: isLoading ? null : onPressed,
//             child: Text(
//               number.toString(),
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//                 color: isLoading ? Colors.grey : Colors.black,
//               ),
//             ),
//           );
//         });
//   }
// }