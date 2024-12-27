
import 'package:butter_app_project/authentication/login.dart';
import 'package:butter_app_project/authentication/register.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome_Page extends StatefulWidget {
  const Welcome_Page({super.key});

  @override
  State<Welcome_Page> createState() => _Welcome_PageState();
}

class _Welcome_PageState extends State<Welcome_Page> {
  int _currentIndex = 0;
  bool _Welcome = false;
  bool _start = false;

  @override
  void initState() {
    // _checkIfVisited();
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _Welcome = true;
      });
    });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _start = true;
      });
    });
  }
  Future<void> _checkIfVisited() async {
    final prefs = await SharedPreferences.getInstance();
    final hasVisited = prefs.getBool('hasVisited') ?? false;

    if (hasVisited) {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => Welcome_Page();
      // ));
    }
  }

  Future<void> deleteCollection() async {
    final collectionRef = FirebaseFirestore.instance.collection('Card_Order');
    
    final querySnapshot = await collectionRef.get();
    
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    print('Koleksi Card_Order telah dihapus.');
  }

  Future<void> _setVisited() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasVisited', true);
  }

  final List<String> _images = [
    'https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/f1ddab52-fc83-42e7-a212-11006204a982_Go-Biz_20220405_153007.jpeg?auto=format',
    'https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/d97085a0-c243-486a-9816-da5c2562e39f_Go-Biz_20221118_211149.jpeg?auto=format',
    'https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/2e9c46c7-614e-41e0-9c7f-5a88377b3a2b_Go-Biz_20220510_140539.jpeg?auto=format',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Container(
          padding:  EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white),
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    items: _images.map((imageUrl) {
                      return CircleAvatar(
                        radius: 150,
                        backgroundImage: NetworkImage(imageUrl),
            
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
            
                  SizedBox(height: 30,),
                  Text("All your " , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  Text("favorite khek food", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  Text("Good food makes you happy", style: TextStyle(color: Colors.grey, fontSize: 12),),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _images.asMap().entries.map((entry) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? Color(0xffB8001F)
                              : Colors.grey.shade400,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 50,),
                  ElevatedButton(onPressed: (){
                    // deleteCollection();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register(),));
                  },
                      child: Text("Continue", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: Color(0xffB8001F),
            
                  ),),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
                  },
                    child: Text("Sign-In", style: TextStyle(color: Color(0xffB8001F)),),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        backgroundColor: Colors.grey[200],
                        elevation: 3
                        // backgroundColor: Color(0xffB7E0FF)
                    ),)
            
            
                  ]
              ),
          ),
        ),
      ),
      
    );
  }
}

// class Choice extends StatefulWidget {
//   const Choice({super.key});
//
//   @override
//   State<Choice> createState() => _ChoiceState();
// }
//
// class _ChoiceState extends State<Choice> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.all(30),
//           width: 400,
//           child: Card(
//             color: Colors.white,
//             elevation: 10,
//             child: Container(
//               margin: EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Liong Tahu" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 30),),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Metal" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
//                         Image(image: NetworkImage("https://st3.depositphotos.com/1067257/14467/v/380/depositphotos_144679293-stock-illustration-human-cartoon-hand-showing-metal.jpg") , width: 50,)
//                         // Image(image: NetworkImage("https://png.pngtree.com/png-clipart/20220930/original/pngtree-cartoon-hand-symbolizing-metal-png-image_8645012.png"), width: 30,)
//                       ],
//                     ),
//                       ],
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text("Login as a ...."),
//                     ),
//                   SizedBox(height: 20),
//                   ElevatedButton(onPressed: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
//                   },
//                       child: Text("Cashier" ,style: TextStyle(color: Color(0xFF850000)),),
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: Size(MediaQuery.of(context).size.width, 50),
//                     shape: ContinuousRectangleBorder(side: BorderSide(color: Color(0xFF850000))),
//                     backgroundColor: Colors.white,
//
//                   ),),
//                   SizedBox(height: 15),
//                   ElevatedButton(onPressed: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Owner_Login(),));
//                   },
//                       child: Text("Owner" ,style: TextStyle(color: Color(0xFF850000))),
//                   style: ElevatedButton.styleFrom(
//                       fixedSize: Size(MediaQuery.of(context).size.width, 50),
//                     shape: ContinuousRectangleBorder(side: BorderSide(color: Color(0xFF850000))),
//                     backgroundColor: Colors.white
//                   ),)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


