
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class Dasboard_Karyawan extends StatefulWidget {
  const Dasboard_Karyawan({super.key});

  @override
  State<Dasboard_Karyawan> createState() => _Dasboard_KaryawanState();
}

class _Dasboard_KaryawanState extends State<Dasboard_Karyawan> {
  InterstitialAd? _interstitialAd;
  final CollectionReference Menu = FirebaseFirestore.instance.collection(
      "Menu");
  final String gojekUrl = "https://gofood.co.id/medan/restaurant/liong-tahu-metal-jl-metal-no-9b-kelurahan-tanjung-mulia-kecamatan-medan-deli-eef5aff0-5eed-473f-9433-8fac2252cc49";

  Future<void> _launchGojek() async {
    final uri = Uri.parse(gojekUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Tidak dapat membuka URL: $gojekUrl';
      }
    } catch (e) {
      print("Error: $e");
    }
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                   Container(
                     margin: EdgeInsets.all(10),
                     width: MediaQuery.of(context).size.width,
                     height: 100,
                     decoration: BoxDecoration(
                       color: Color(0x33B8001F),
                       borderRadius: BorderRadius.circular(10)
                     ),
                   ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xffB8001F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery to home" , style: TextStyle(color: Colors.white),),
                              IconButton(
                                onPressed: (){
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
                                    _launchGojek();
                                  } else {
                                    _launchGojek();
                                    debugPrint("Iklan belum siap.");

                                  }
                                },
                                icon: Icon(Icons.arrow_forward_ios , color: Colors.white,))
                            ],
                          ),
                          Text("at metal street no 9B" , style: TextStyle(color: Colors.white, fontSize: 10),)
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(colors: [Color(0xfff2f9ff) , Color(0xfff5f7f8)])
                      gradient: LinearGradient(
                          colors: ([Color(0xffF1F0E8),
                            Color(0xffE5E1DA)
                          ]),
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nasi Babi Kecap" , style: TextStyle(color: Colors.black , fontSize: 15 , fontWeight: FontWeight.bold),),
                        Text("Available", style: TextStyle(color: Colors.black),),
                          SizedBox(height: 20,),
                          ElevatedButton(onPressed: (){},
                              child: Text("Discount 10%" , style: TextStyle(color: Colors.white , fontSize: 12),),
                          style: ElevatedButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            backgroundColor: Color(0xffB8001F)
                          ),)
                          // child: Image(image: AssetImage("assets/dasboard_pic-removebg-preview.png") , width: 200,),
          
                      ],
                    ),
                  ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage("https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/d97085a0-c243-486a-9816-da5c2562e39f_Go-Biz_20221118_211149.jpeg?auto=format"),
                          ),),
                    )
                ]
                ),
                SizedBox(height: 30,),
                Text("Top of Week" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 17),),
                SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/eb829dd3-9a93-4b28-9650-e7250e102f97_Go-Biz_20220417_171818.jpeg?auto=format",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 150,
                                ),
                              ),
          
                              Text("Bakmie + Bakso Fiyen" , style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5),
                              Text("Rp 33.000" , style: TextStyle(color: Color(0xff47663B) , fontSize: 12),)
                            ],
                          ),
                        ),
                      ),
          
                      Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/c3447ebc-68b4-4d37-a97c-f46666ff27eb_Go-Biz_20220627_111126.jpeg?auto=format",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 150,
                                ),
                              ),
          
                              Text("Pangsit / Wonton" , style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5),
                              Text("Rp 21.999" , style: TextStyle(color: Color(0xff47663B) , fontSize: 12),)
                            ],
                          ),
                        ),
                      ),
          
          
                      Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/3800bae6-d10d-4e0e-a614-a90134acff4e_Go-Biz_20240507_113507.jpeg?auto=format",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 150,
                                ),
                              ),
          
                              Text("Paket 5 kombinasi LTm" , style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5),
                              Text("Rp 55.000" , style: TextStyle(color: Color(0xff47663B) , fontSize: 12),)
                            ],
                          ),
                        ),
                      ),
          
                      Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/d97085a0-c243-486a-9816-da5c2562e39f_Go-Biz_20221118_211149.jpeg?auto=format",
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: 150,
                                ),
                              ),
          
                              Text("Babi Kecap" , style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                              SizedBox(height: 5),
                              Text("Rp 58.000" , style: TextStyle(color: Color(0xff47663B) , fontSize: 12),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // SizedBox(height: 30,),
                // Text("Recommendation" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 17),),
                //
                // GridView.builder(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 10,
                //     mainAxisSpacing: 10,
                //     childAspectRatio: 2/2,
                //   ),
                //   itemCount: 6,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     return Container(
                //       child: Card(
                //         elevation: 5,
                //         child: Center(
                //           child: Text(
                //             "Item ${index + 1}",
                //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                //
                //
              ],
            ),
          ),
        ),
      ),


    );

  }
}


