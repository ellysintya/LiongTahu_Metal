import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Histories extends StatefulWidget {
  const Histories({super.key});

  @override
  State<Histories> createState() => _HistoriesState();
}

class _HistoriesState extends State<Histories> {
  final CollectionReference History = FirebaseFirestore.instance.collection("History");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(stream: History.snapshots() ,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: SpinKitChasingDots(
                  color: Color(0xffB8001F),
                  size: 50.0,
                ));
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Lottie.asset("assets/lottie/no data.json"));
              }

              final data = snapshot.data!.docs;

              return Expanded(
                  child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                final history = data[index].data() as Map<String, dynamic>;
                  return SingleChildScrollView(
                    // scrollDirection: Axis.horizontal,
                    child: Card(
                      elevation: 5,
                      surfaceTintColor: Color(0xffB8001F),
                      shadowColor: Color(0xffB8001F),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(DateFormat('dd-MM-yyyy HH:mm').format((history['tanggal'] as Timestamp).toDate())),
                                  Text(history["no_meja"]),
                                  Row(
                                    children: [
                                      Text(history["nama_kasir"]),
                                      SizedBox(width: 15,),
                                      Text("Rp ${history["Total"].toString()}" , style: TextStyle(color: Color(0xff47663B))),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  );
                }
              )
              );
            },),
      ),
    );
  }
}
