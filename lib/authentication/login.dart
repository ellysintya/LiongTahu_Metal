import 'package:butter_app_project/authentication/register.dart';
import 'package:butter_app_project/navbar.dart';
import 'package:butter_app_project/pages/card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  // final LocalAuthentication auth = LocalAuthentication();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isObscured = true;
  bool Obscured_Daftar = true;
  bool Obscured_Owner = true;

  String? error_Username;
  String? error_Pass;

  TextEditingController _passKaryawan = TextEditingController();
  TextEditingController _passDaftar = TextEditingController();
  TextEditingController _owner = TextEditingController();
  TextEditingController _usernameKaryawan = TextEditingController();

  void Login(BuildContext context) async {
    try {
      var credential = await auth.signInWithEmailAndPassword(
          email: _usernameKaryawan.text, password: _passKaryawan.text);
      print(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully sign-in"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => NavBar(),));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("pengguna tidak ditemukan");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Wrong email"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      } else if (e.code == "wrong-possword") {
        print("tidak ada");
      }
    } catch (e) {
      print("error $e");
    }
  }

  // void checkUser(String nama, String pass) async {
  //   KaryawanDB db = KaryawanDB();
  //   Map<String, dynamic>? user = await db.fetchData(nama, pass);
  //   if (user != null) {
  //     print('User found: ${user['nama']}');
  //     Navigator.of(context).push(
  //         MaterialPageRoute(builder: (context) => Dashboard(),));
  //   } else {
  //     error_Pass = "Password tidak sesuai";
  //     error_Username = "Username tidak sesuai";
  //   }
  // }


  @override
  void dispose() {
    _passKaryawan.dispose();
    _usernameKaryawan.dispose();
    _passDaftar.dispose();
    _owner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        height: MediaQuery
            .of(context)
            .size
            .height,
        padding: EdgeInsets.all(30),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row( // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back ",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Image(image: NetworkImage(
                        "https://st3.depositphotos.com/1067257/14467/v/380/depositphotos_144679293-stock-illustration-human-cartoon-hand-showing-metal.jpg"),
                      width: 50,)
                  ],
                ),
                Text(
                  "Sign-In your account", style: TextStyle(color: Colors.grey),),
                SizedBox(height: 30),
                Text("Email"),
                SizedBox(height: 10),
                TextField(
                  controller: _usernameKaryawan,
                  decoration: InputDecoration(
                    hintText: "your email",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        // fontWeight: FontWeight.bold,
                        fontSize: 15),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    errorText: error_Username,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 50),
                Text("Password"),
                SizedBox(height: 10),
                TextField(
                  controller: _passKaryawan,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      errorText: error_Pass,
                      hintText: "your password",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        // fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                          icon: Icon(
                            isObscured ? Icons.visibility_off : Icons.visibility,
                            color: Colors.black,))),
                  obscureText: isObscured,
                ),
                TextButton(
                    onPressed: () async {
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(color: Color(0xffB8001F)),
                    )),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Login(context);
                    // print("button pressed");
                    // checkUser(_usernameKaryawan.text, _passKaryawan.text);
                  },
                  child: Text("Sign-In"),
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
                    Text(" Dont't have an account ?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register(),));
                      },
                      child: Text(
                        "Sign-Up", style: TextStyle(color: Color(0xffB8001F)),),
                    ),
                    Expanded(child: Divider())
                  ],
                ),
              ],
            ),
          
          ),
        ),),
    );
  }
}
