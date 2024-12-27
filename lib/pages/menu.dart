import 'dart:convert';
import 'dart:typed_data';

import 'package:butter_app_project/jenisMenu/Beverage.dart';
import 'package:butter_app_project/jenisMenu/Rice.dart';
import 'package:butter_app_project/jenisMenu/bakMie.dart';
import 'package:butter_app_project/jenisMenu/liongTahu.dart';
import 'package:butter_app_project/pages/add_page/addMenu_Home.dart';
import 'package:butter_app_project/pages/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

class Menu_Dashboard extends StatefulWidget {
  const Menu_Dashboard({super.key});

  @override
  State<Menu_Dashboard> createState() => _Menu_DashboardState();
}

class _Menu_DashboardState extends State<Menu_Dashboard> {
  int jlh = 0 ;
  InterstitialAd? _interstitialAd;
  Uint8List? selectedImage;
  BannerAd? _bannerAd;
  final CollectionReference Menu = FirebaseFirestore.instance.collection("Menu");
  final CollectionReference Card_Order = FirebaseFirestore.instance.collection("Card_Order");
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();

  void _DecrementCounter() {
    setState(() {
      jlh--;
      print(jlh);
    });
  }

  void _incrementCounter() {
    setState(() {
      jlh++;
      print(jlh);
    });
  }

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


  void SearchMenu() async{
    try {
      QuerySnapshot data = await db.collection("Menu")
          .where("nama", isGreaterThanOrEqualTo: searchController.text)
          .where("nama", isLessThan: searchController.text + 'z')
          .get();
      for(var element in data.docs){
        print(element.data());
      }
    }catch(e){
      print(e);
    }
  }

  void initState(){
    SearchMenu();
    loadAd();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  hintText: "Search on LTM",
                  hintStyle: TextStyle(
                    color: Color(0xffB8001F),
                    fontSize: 15,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xffB8001F),
                  ),
                  
                ),
                onChanged: (value) {
                setState(() {});}
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            automaticIndicatorColorAdjustment: true,
            indicatorColor: Color(0xffB8001F),
            labelColor: Color(0xffB8001F),
            tabs: [
              Tab(text: "All"),
              Tab(text: "Liong Tahu"),
              Tab(text: "Beverage"),
              Tab(text: "Bakmie"),
              Tab(text: "Rice",)
            ],
          ),
          actions: [IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderBasket(),));
          },
              icon: Icon(Icons.shopping_basket_sharp , color: Color(0xffB8001F),))],
        ),
        body: TabBarView(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
                child:  StreamBuilder(stream: searchController.text.isEmpty ? Menu.snapshots() :
            Menu.where("nama" , isGreaterThanOrEqualTo: searchController.text).where("nama", isLessThan: searchController.text + "z").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: SpinKitChasingDots(
                    color: Color(0xffB8001F),
                    size: 50.0,
                  ),);
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child:  Lottie.asset("assets/lottie/no data.json"));
                }

                final data = snapshot.data!.docs;

                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final mn = data[index].data() as Map<String, dynamic>;
                      int totalPrice =  int.parse(mn["harga"]) * jlh ;
                      String? base64String = mn["foto_menu"];
                      if (base64String == null || base64String.isEmpty){
                        Lottie.asset("assets/lottie/no pic.json");
                      } else {
                        Uint8List imageBytes = base64Decode(base64String);
                        return Card(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(context: context,
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          // height: 800,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            children: [
                                              Center(child: Image(image: MemoryImage(imageBytes))),

                                              SizedBox(height: 20,),
                                              Text(mn["nama"], style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),),
                                              Text(mn["deskripsi"],
                                                style: TextStyle(fontSize: 15,
                                                    color: Colors.grey
                                                        .shade400),),
                                              SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: _DecrementCounter,
                                                        child: Icon(Icons.remove,
                                                          color: Colors.black,),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape: CircleBorder(
                                                              side: BorderSide(
                                                                  color: Color(
                                                                      0xffB8001F),
                                                                  width: 2)
                                                          ),
                                                        ),),
                                                      Text('$jlh'),

                                                      ElevatedButton(
                                                          onPressed: _incrementCounter,
                                                          child: Icon(Icons.add,
                                                            color: Colors.black,),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              shape: CircleBorder(
                                                                  side: BorderSide(
                                                                      color: Color(
                                                                          0xff47663B),
                                                                      width: 2)
                                                              ))
                                                      ),
                                                    ],
                                                  ),
                                                  Text(mn["harga"],
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xff47663B),
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 15)
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 30,),
                                              Align(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(jlh > 0 ? "Rp.${int.parse(
                                                        mn["harga"]) * jlh}" : "",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Color(
                                                                0xff47663B))),
                                                    ElevatedButton(onPressed: ()  async{
                                                      int harga = int.parse(mn['harga'].toString());
                                                      int totalHarga = harga * jlh;
                                                      String selectedImage = base64Encode(imageBytes);
                                                      try {
                                                        await FirebaseFirestore.instance.collection("Card_Order").add({
                                                          'nama_menu': mn['nama'],
                                                          'harga_satuan': mn['harga'],
                                                          'total_harga': totalHarga,
                                                          'foto_menu': selectedImage,
                                                          'jumlah': jlh,
                                                        });

                                                      } catch (e) {
                                                        print("Terjadi kesalahan: $e");
                                                      }
                                                      Navigator.of(context).pop();
                                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dasboard()));
                                                      jlh = 0;
                                                    },
                                                      child: Text(
                                                          jlh > 0 ? "Order" : "",
                                                          style: TextStyle(
                                                            color: Colors.white,)),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                          backgroundColor: jlh > 0
                                                              ? Color(0xff47663B)
                                                              : null,
                                                          shape: ContinuousRectangleBorder(),
                                                          minimumSize: Size(
                                                              MediaQuery
                                                                  .of(context)
                                                                  .size
                                                                  .width / 2, 50)
                                                      ),),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      imageBytes,
                                      fit: BoxFit.cover
                                      ,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text(mn["nama"], style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5),
                                  Text("Rp ${mn["harga"]}", style: TextStyle(
                                      color: Color(0xff47663B), fontSize: 12),)
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              },)),
            Center(child: LiongTahu()),
            Center(child: Beverage_()),
            Center(child: Bakmie()),
            Center(child: Rice_()),
          ],
        ),

        // floatingActionButton: FloatingActionButton(onPressed: (){
        //   if (_interstitialAd != null) {
        //     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        //       onAdDismissedFullScreenContent: (ad) {
        //         debugPrint("Iklan ditutup oleh pengguna.");
        //         ad.dispose();
        //         loadAd();
        //       },
        //       onAdFailedToShowFullScreenContent: (ad, error) {
        //         debugPrint("Gagal menampilkan iklan: $error");
        //         ad.dispose();
        //         loadAd();
        //       },
        //     );
        //
        //     _interstitialAd!.show();
        //     _interstitialAd = null;
        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMenus(),));
        //   } else {
        //     debugPrint("Iklan belum siap.");
        //   }
        // }, shape: CircleBorder(),
        //   backgroundColor: Color(0x33B8001F),
        //
        //   child: Icon(Icons.add , color: Colors.white,),),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}




