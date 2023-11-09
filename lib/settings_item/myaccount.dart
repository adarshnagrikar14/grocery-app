// ignore_for_file: use_build_context_synchronously

import 'package:demoapp/dashboard_pages/dashboard.dart';
import 'package:demoapp/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final User? user = FirebaseAuth.instance.currentUser;
  late String _name;
  late String _email;
  late String _profile;

  @override
  void initState() {
    super.initState();

    setState(() {
      _name = user!.displayName!;
      _email = user!.email!;
      _profile = user!.photoURL!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade100,
                Colors.green.shade50,
                Colors.green.shade50,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
              ),
              color: Colors.green.shade50,
              child: Center(
                child: CircleAvatar(
                  radius: 66.0,
                  backgroundColor: Colors.black,
                  child: Hero(
                    tag: "ProfileImage",
                    child: CircleAvatar(
                      radius: 65.0,
                      backgroundImage: NetworkImage(
                        _profile,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 20.0,
                ),
                child: Text(
                  "Profile Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    fontFamily: GoogleFonts.tiltNeon().fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                top: 15.0,
                right: 12.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                  border: Border.all(
                    color: Colors.black38,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(
                    8.0,
                  ),
                  child: Text(
                    "Name and Gmail is autofetched from the Account You provided while Login.",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const Space(top: 20, bottom: 0),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
              ),
              child: Text(
                _name,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
              ),
              child: Text(
                _email,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            const Space(top: 30, bottom: 0),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Log out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            RoundedBorderButton(
              onTap: () => signOutAndNavigateToLogin(),
              text: "Logout",
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signOutAndNavigateToLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth authFirebase = FirebaseAuth.instance;

    await googleSignIn.signOut();
    await authFirebase.signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
