import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/modules/coin.dart';
import '../constants/colors.dart';
import '../constants/font.dart';
import '../modules/usersclass.dart';

late List<CameraDescription> _cameras;

/// Footprint is the Main Application.
class Footprint extends StatefulWidget {
  /// Default Constructor
  Footprint(this.cameras, {Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  State<Footprint> createState() => _FootprintState();
}

class _FootprintState extends State<Footprint> {
  late CameraController controller;
  bool isCam = false;
  double coin = 0.0;
  double newcoin = 0.0;

  @override
  void initState() {
    super.initState();
    // print(widget.cameras);
    if (widget.cameras == null || widget.cameras.isEmpty) {
      // print('No Cameras Found.');
    } else {
      controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );

      controller.initialize().then((_) {
        if (!mounted) {
          Navigator.pop(context);
        }
      });
    }

// here
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!controller.value.isInitialized) {

    //   Navigator.pop(context);
    // }
    var user = Provider.of<Users>(context, listen: true).user;
    DateTime lastScan = HttpDate.parse("user.data.lastScan");
    // DateTime lastScan = HttpDate.parse(user.data.lastScan);
    Duration remaining = DateTime.now().difference(lastScan);
// generate random int
    Timer.periodic(
      const Duration(seconds: 4),
      (timer) => setState(() {
        newcoin = Random().nextInt(3) / 10;
        coin += newcoin;
      }),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: f5("Footprint", 16),

        // cart icon
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10, top: 15),
              child: text("R: ${24 - remaining.inHours} Hours", 16)),
        ],

        // pop icon
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: deepgreen,
          ),
        ),
      ),
      body: isCam
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  CameraPreview(controller),
                  text("Coin: ∆$newcoin", 18, color: white)
                ],
              ),
            )
          : Center(
              child: TextButton(
                onPressed: () async {
                  update(user.data!.username);
                  Provider.of<Users>(context, listen: false)
                      .users(username: user.data.username);
                  setState(() => isCam = true);
                },
                child: text("Continue", 14),
              ),
            ),
    );
  }
}


// CameraPreview(controller),