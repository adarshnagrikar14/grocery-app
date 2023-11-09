// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:demoapp/walkthrough.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _authFirebase = FirebaseAuth.instance;

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result = await _authFirebase.signInWithCredential(
        authCredential,
      );

      if (result != null) {
        Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WalkThrough(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error occurred",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    signup(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
                Container(
                  height: 80.0,
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                  child: Image.asset("assets/images/logo.jpg"),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 30.0,
                  ),
                  child: Text(
                    "Login to continue",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 40.0,
                    right: 50.0,
                    left: 50.0,
                  ),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Mobile Number',
                        prefixText: "+91",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                            image: AssetImage(
                              "assets/images/flag.png",
                            ),
                            height: 10.0,
                            width: 10.0,
                          ),
                        )),
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.7, 50.0),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.green.shade500,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 48.0),
                  child: Text(
                    "Or continue with...",
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ElevatedButton(
                    onPressed: () => signup(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.grey.shade200,
                      surfaceTintColor: Colors.green,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.2, 50.0),
                    ),
                    child: const Image(
                      image: AssetImage(
                        "assets/images/google.png",
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    "By continuing, you agree to the\nTerms of services",
                    style: TextStyle(color: Colors.black87, fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 80.0,
                  padding: const EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 20.0),
                  child: Image.asset("assets/images/logo.jpg"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
