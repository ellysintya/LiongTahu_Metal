import 'package:butter_app_project/authentication/login.dart';
import 'package:butter_app_project/authentication/welcome.dart';
import 'package:butter_app_project/pages/add_page/addMenu_Home.dart';
import 'package:butter_app_project/pages/profile/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

class Profile_User extends StatefulWidget {
  const Profile_User({super.key});

  @override
  State<Profile_User> createState() => _Profile_UserState();
}

class _Profile_UserState extends State<Profile_User> {
  InterstitialAd? _interstitialAd;
  FirebaseAuth auth = FirebaseAuth.instance;

  void loadAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            _interstitialAd = ad;
          });
          debugPrint("Iklan berhasil dimuat.");
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Iklan gagal dimuat: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  void Logout(BuildContext context) async{
    await auth.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Logged Out"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2), // Durasi tampil snackbar
      ),
    );
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Color(0xffB8001F)),
      // ),
      body: Container(
        // padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 350 , left: 10 , right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMenus(),));
                    },
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined , color: Color(0xffB8001F),),
                            SizedBox(width: 20),
                            Text("Add New Menu" , style: TextStyle(color: Color(0xffb8001F)),)
                          ],
                        ), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white
                      ),),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Histories(),));
                    },
                        child: Row(
                          children: [
                            Icon(Icons.history , color: Color(0xffb8001F),),
                            SizedBox(width: 20 ),
                            Text("Payment History",  style: TextStyle(color: Color(0xffb8001F)))
                          ],
                        ), style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white
                    ),),
                    ElevatedButton(onPressed: (){},
                      child: Row(
                        children: [
                          Icon(Icons.edit , color: Color(0xffb8001F),),
                          SizedBox(width: 20 ),
                          Text("Edit Menu",  style: TextStyle(color: Color(0xffb8001F)))
                        ],
                      ), style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                      ),),
                    SizedBox(height: 50),
                    ElevatedButton(onPressed: (){
                    if (_interstitialAd != null) {
                        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
                          onAdDismissedFullScreenContent: (ad) {
                            debugPrint("Iklan ditutup oleh pengguna.");
                            ad.dispose();
                            loadAd();
                          },
                          onAdFailedToShowFullScreenContent: (ad, error) {
                            debugPrint("Gagal menampilkan iklan: $error");
                            ad.dispose();
                            loadAd();
                          },
                        );

                        _interstitialAd!.show();
                        _interstitialAd = null;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMenus(),));
                      } else {
                        debugPrint("Iklan belum siap.");
                      }
                      Logout(context);
                    },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login , color: Colors.white,),
                          SizedBox(width: 20),
                          Text("Log-Out" , style: TextStyle(color: Colors.white),)
                        ],
                      ), style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffB8001F)
                      ),),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                height: 350,
                decoration: BoxDecoration(
                    color: Color(0xffB8001F),
                borderRadius: BorderRadius.circular(30)),
                child: SafeArea(
                  child: Column(
                    children: [
                      ClipRRect(
                        child: CircleAvatar(child: Lottie.asset("assets/lottie/profile2.json"),
                          radius: 100,
                        backgroundColor: Colors.white,),
                      ),
                      SizedBox(height: 20,),
                      Text("Aswin Angkasa" , style: TextStyle(color: Colors.white),),
                      Text("Liong Tahu Metal Owner" , style: TextStyle(color: Colors.white) ,)

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      
    );
  }
}
