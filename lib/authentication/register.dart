
import 'package:butter_app_project/authentication/login.dart';


import 'package:butter_app_project/pages/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference Pengguna = FirebaseFirestore.instance.collection(
      "Pengguna");
  FirebaseFirestore db = FirebaseFirestore.instance ;
  // KaryawanDB karyawanDB = KaryawanDB();
  bool isObscuredDaftar = true;
  TextEditingController _passDaftar = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _noTelepon = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    _passDaftar.dispose();
    _username.dispose();
    _noTelepon.dispose();
    _email.dispose();
    super.dispose();
  }

  void Register(BuildContext context) async{
    if (_username.text.isEmpty ||
          _passDaftar.text.isEmpty ||
          _email.text.isEmpty ||
          _noTelepon.text.isEmpty) {
        _showDialog("All fields are required.");
        return;
      }

      if (!_email.text.contains('@')) {
        _showDialog("Invalid email format.");
        return;
      }
    try{
      var credential = await auth.createUserWithEmailAndPassword(email: _email.text, password: _passDaftar.text);
      print("berhasil");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully create an account"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
      // _createAccount();
      CreatePengguna();

    } on FirebaseAuthException catch(e){
      if (e.code == "weak-password"){
        print("password lemah");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("your password is weak"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }else if (e.code == "email-already-in-user"){
        print("email sudah digunakan");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("email is already registered"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e){
      print("error : $e");
    }
  }

  void CreatePengguna() async {
    try{
      db.collection("Pengguna").doc().set({"username" : _username.text , "password" : _passDaftar.text ,"email" : _email.text , "No telepon" : _noTelepon.text });
      print("Success");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Berhasil Tertambah"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
    }catch(e){
      print(e);

    }
  }
  // void _createAccount() async {
  //   if (_username.text.isEmpty ||
  //       _passDaftar.text.isEmpty ||
  //       _email.text.isEmpty ||
  //       _noTelepon.text.isEmpty) {
  //     _showDialog("All fields are required.");
  //     return;
  //   }
  //
  //   if (!_email.text.contains('@')) {
  //     _showDialog("Invalid email format.");
  //     return;
  //   }
  //
  //   try {
  //     await karyawanDB.insert(MdKaryawan(
  //         nama: _username.text,
  //         pass: _passDaftar.text,
  //         email: _email.text,
  //         no_telp: int.parse(_noTelepon.text)));
  //
  //
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
  //   } catch (e) {
  //     _showDialog("Failed to create account: $e");
  //   }
  // }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Notice"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey.shade100,),
      style: TextStyle(color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body:
         SingleChildScrollView(
           child: Container(
             padding: EdgeInsets.all(20),
             decoration: BoxDecoration(color: Colors.white),
             child: SafeArea(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       Text(
                         "Sign-Up",
                         style:
                         TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                       ),
                       Image(image: NetworkImage(
                           "https://st3.depositphotos.com/1067257/14467/v/380/depositphotos_144679293-stock-illustration-human-cartoon-hand-showing-metal.jpg"),
                         width: 50,)
                     ],
                   ),
                   Text(
                     "Create account and help customer to order", style: TextStyle(color: Colors.grey),),
                   SizedBox(height: 30),
                   Text("Username"),
                   SizedBox(height: 10),
                   _buildTextField(_username, 'Username'),
                   SizedBox(height: 30),
                   Text("Password"),
                   SizedBox(height: 10),
                   TextField(
                     controller: _passDaftar,
                     decoration: InputDecoration(
                         border: InputBorder.none,
                         filled: true,
                         fillColor: Colors.grey.shade100,
                         hintText: "your password",
                         hintStyle: TextStyle(
                           color: Colors.grey.shade500,
                           // fontWeight: FontWeight.bold,
                           fontSize: 15,
                         ),
                         suffixIcon: IconButton(
                             onPressed: () {
                               setState(() {
                                 isObscuredDaftar = !isObscuredDaftar;
                               });
                             },
                             icon: Icon(
                               isObscuredDaftar ? Icons.visibility_off : Icons.visibility,
                               color: Colors.black,))),
                     obscureText: isObscuredDaftar,
                   ),
                   SizedBox(height: 30),
                   Text("Email"),
                   SizedBox(height: 10),
                   _buildTextField(_email, 'Email'),
                   SizedBox(height: 30),
                   Text("No Telp"),
                   SizedBox(height: 10),
                   _buildTextField(_noTelepon, 'No Telepon'),
                   SizedBox(height: 50),
                   ElevatedButton(
                     onPressed: (){
                       Register(context);
                       // _createAccount();
                     },
                     child: Text("Create"),
                     style: ElevatedButton.styleFrom(
                         fixedSize: Size(MediaQuery
                             .of(context)
                             .size
                             .width, 50),
                         foregroundColor: Colors.white,
                         backgroundColor: Color(0xffB8001F),
                         elevation: 5,
                         shape: ContinuousRectangleBorder(
                             borderRadius: BorderRadius.circular(10)
                         )
                     ),
                   ),
                   SizedBox(height: 50),
                   Row(
                     children: [
                       Expanded(
                         child: Divider(
                           thickness: 1,
                         ),
                       ),
                       Text(" Have an account ?"),
                       TextButton(
                         onPressed: () {
                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
                         },
                         child: Text(
                           "Sign-In", style: TextStyle(color: Color(0xffB8001F)),),
                       ),
                       Expanded(child: Divider())
                     ],
                   ),
                 ],
               ),
             ),
           
                 ),
         ),
    );
  }
}

