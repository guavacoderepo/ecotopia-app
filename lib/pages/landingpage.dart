import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("hello world"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(IconlyLight.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(IconlyLight.chat), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.wallet), label: "Wallet"),
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.profile), label: "Profile")
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
