import 'package:butter_app_project/authentication/insert_pin.dart';
import 'package:butter_app_project/authentication/welcome.dart';
import 'package:butter_app_project/home.dart';
import 'package:butter_app_project/pages/add_page/addMenu_Home.dart';
import 'package:butter_app_project/pages/card.dart';
import 'package:butter_app_project/pages/menu.dart';
import 'package:butter_app_project/pages/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int current = 0;
  Widget bodyPage(int index) {
    if (index == 0) {
      return Dasboard_Karyawan();
    } else if (index == 1){
      return Menu_Dashboard();
    }else if(index== 2 ){
      return PaymentPage();
    }else {
      return InsertPin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyPage(current),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              activeIcon: Lottie.asset("assets/lottie/home_icon.json" , width: 60)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: "Menu",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.paypal),
              label: "Payment",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'owner',
            ),
          ],
          // selectedFontSize: double.maxFinite,
          selectedItemColor: Color(0xffB8001B),
          unselectedItemColor: Colors.grey,
          currentIndex: current,
          onTap: (int index) {
            setState(() {
              current = index;
            });
          },
        ),

    );
  }
}