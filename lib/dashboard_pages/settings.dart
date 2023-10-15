// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:demoapp/listitems/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    void _onLinkTapped() {}

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileCard(
              name: _name,
              email: _email,
              imagePath: _profile,
            ),
            const Space(),
            MyListeItem(
              title: "My Account",
              subtitle: "See your profile",
              icon: Icons.account_circle_rounded,
              destinationClass: (context) => const MyAccountPage(),
            ),
            const Space(),
            MyListeItem(
              title: "My Addresses",
              subtitle: "See your added addresses",
              icon: Icons.location_on,
              destinationClass: (context) => const MyAccountPage(),
            ),
            const Space(),
            MyListeItem(
              title: "Notification Settings",
              subtitle: "Manage notification settings",
              icon: Icons.notifications,
              destinationClass: (context) => const MyAccountPage(),
            ),
            const Space(),
            MyListeItem(
              title: "Manage Permissions",
              subtitle: "Manage your all permissions",
              icon: Icons.manage_accounts_rounded,
              destinationClass: (context) => const MyAccountPage(),
            ),
            const Space(),
            Padding(
              padding: const EdgeInsets.only(
                top: 28.0,
                right: 12.0,
                left: 12.0,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "You agree to follow the ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Terms and conditions",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = _onLinkTapped,
                    ),
                    const TextSpan(
                      text: " for using the App.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyListeItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  final Widget Function(BuildContext context)? destinationClass;

  const MyListeItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.destinationClass,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destinationClass!(context),
            ),
          );
        },
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.green.shade400,
          ),
          title: Text(
            title,
          ),
          subtitle: Text(
            subtitle,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String imagePath;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.0,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(imagePath),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Space extends StatelessWidget {
  const Space({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 10.0,
      ),
      child: SizedBox(
        height: 1.0,
        child: Container(
          color: Colors.black12,
        ),
      ),
    );
  }
}
