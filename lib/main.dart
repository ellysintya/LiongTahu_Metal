
import 'package:butter_app_project/authentication/insert_pin.dart';
import 'package:butter_app_project/authentication/welcome.dart';
import 'package:butter_app_project/model/save_helper.dart';
import 'package:butter_app_project/pages/payment.dart';
import 'package:butter_app_project/pages/profile/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GambarProvider()),
        ChangeNotifierProvider(create: (_) => SaveUrl())
      ],
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
    indicatorColor: const Color(0xff850000)),
    home: Welcome_Page(),
    )
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int jlh = 0; // Nilai awal dari jlh

  // Fungsi untuk mengurangi nilai jlh
  void _DecrementCounter() {
    setState(() {
      jlh--; // Mengurangi nilai jlh
      print("Nilai jlh setelah decrement: $jlh"); // Debugging
    });
  }

  // Fungsi untuk menambah nilai jlh
  void _incrementCounter() {
    setState(() {
      jlh++; // Menambah nilai jlh
      print("Nilai jlh setelah increment: $jlh"); // Debugging
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _DecrementCounter,
              child: Icon(Icons.remove, color: Colors.black),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(color: Color(0xffB8001F), width: 2),
                ),
              ),
            ),
            SizedBox(height: 20), // Spasi antara tombol dan angka
            Text(
              '$jlh', // Menampilkan nilai jlh
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20), // Spasi antara angka dan tombol
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Icon(Icons.add, color: Colors.black),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(
                  side: BorderSide(color: Color(0xff47663B), width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

