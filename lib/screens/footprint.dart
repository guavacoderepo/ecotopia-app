import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/requestmodels/coin.dart';
import '../constants/colors.dart';
import '../utilities/font.dart';
import '../requestmodels/usersclass.dart';

/// Footprint is the Main Application.
class Footprint extends StatefulWidget {
  /// Default Constructor
  const Footprint(this.cameras, {Key? key}) : super(key: key);
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
    if (widget.cameras.isEmpty) {
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
    var user = Provider.of<Users>(context, listen: true).user;
    DateTime lastScan = HttpDate.parse(user.data!.lastScan as String);
    Duration remaining = DateTime.now().difference(lastScan);
// generate random int
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: f5("Footprint", 16),

        // cart icon
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 15),
            child: text(
              24 - remaining.inHours < 0
                  ? "0"
                  : "R: ${24 - remaining.inHours} Hours",
              16,
            ),
          ),
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
                onPressed: () {
                  update(user.data!.username).then((value) async {
                    await users(context).then((value) {
                      setState(() => isCam = true);
                    });
                  });
                },
                child: text("Continue", 14),
              ),
            ),
    );
  }
}


// CameraPreview(controller),