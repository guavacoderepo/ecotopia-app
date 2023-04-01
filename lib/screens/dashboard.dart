import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/constants/colors.dart';
import 'package:technovationapp/constants/font.dart';
import 'package:technovationapp/modules/usersclass.dart';
import 'package:technovationapp/screens/bankpayment.dart';
import 'package:technovationapp/screens/donate.dart';
import 'package:technovationapp/screens/news.dart';
import 'package:technovationapp/screens/profile.dart';
import 'package:technovationapp/screens/store.dart';
import 'package:technovationapp/utilities/variables.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';
import 'realtime/live_camera.dart';

List<CameraDescription> cameras = [];

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void cameraDetection() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveFeed(cameras),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Usersclass user = Provider.of<Users>(context).user;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMMM, y').format(now);
    return Scaffold(
      backgroundColor: lightwhite,
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: text("Hello, ${user.data.username}", 18,
            color: black, weight: FontWeight.w600),
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundColor: deepgreen,
            child: IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile())),
              icon: const Icon(
                IconlyLight.profile,
                color: white,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton(
              offset: const Offset(0, 5),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: f1("About", 13, color: black),
                ),
                PopupMenuItem(
                  value: 2,
                  child: f1("Privacy policy", 13, color: black),
                ),
                PopupMenuItem(
                  value: 3,
                  child: f1("Logout", 13, color: black),
                ),
              ],
              child: const Icon(
                IconlyLight.setting,
                color: deepgreen,
              ),
            ),
            // child: IconButton(
            //   onPressed: () async {
            //     await delete();
            //     Navigator.pushReplacement(context,
            //         MaterialPageRoute(builder: (context) => const Login()));
            //   },
            //   icon: const Icon(
            //     IconlyLight.setting,
            //     color: deepgreen,
            //   ),
            // ),
          )
        ],
      ),
// main body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // top card design
                // margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 190,
                decoration: BoxDecoration(
                  color: deepgreen.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  // bg image
                  // image: DecorationImage(
                  //   // image: AssetImage("assets/topimg.png"),
                  //   image: NetworkImage(
                  //       "https://t4.ftcdn.net/jpg/00/21/77/05/360_F_21770579_J48bIXW1eWGV6VRY5E8wMslwTHcrVYqe.jpg"),
                  //   fit: BoxFit.contain,
                  // ),
                ),
                // card content
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // balance column
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        f1("∆${user.data.balance.toStringAsFixed(2)}", 23,
                            color: black),
                        Flexible(
                          child: f1(user.data.address, 10, color: black),
                        ),
                      ],
                    ),
                    // text area
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20),
                    //   child: f5a(
                    //       "®Let's keep our climate safe and earn Eco coin", 14,
                    //       color: black),
                    // ),

                    // donate section

                    MaterialButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Contribute())),
                      color: white,
                      child: f7("Donate CO2 Emitters", 14, color: black),
                    ),

                    MaterialButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BankPayment())),
                      color: white,
                      child: f7("Transfer coin to Bank", 14, color: black),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     MaterialButton(
                    //       onPressed: () => Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const Contribute())),
                    //       color: deepgreen,
                    //       child: f7("Donate CO2 Emitters", 10, color: white),
                    //     ),
                    //     // tranfer to bank account
                    //     MaterialButton(
                    //       onPressed: () => Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const BankPayment())),
                    //       color: textgrey.withOpacity(0.5),
                    //       child: f7("Transfer coin to Bank", 10, color: white),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              vgap(10),
              // top card ends here

              // 1) weather card
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, top: 10),
              //   child: f6("Weather", 16),
              // ),
              weather(formattedDate),

              vgap(20),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
// footprint section
                    InkWell(
                      onTap: () => cameraDetection(),
                      child: Container(
                        color: const Color(0xff637BFF).withOpacity(0.1),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 2.25,
                        height: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calculate_outlined,
                              size: 70,
                              color: const Color(0xff637BFF).withOpacity(0.3),
                            ),
                            f1("Footprint", 17, color: black)
                          ],
                        ),
                      ),
                    ),

// store section
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Store())),
                      child: Container(
                        color: const Color(0xffF19A1A).withOpacity(0.1),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 2.25,
                        height: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 70,
                              color: const Color(0xffF19A1A).withOpacity(0.3),
                            ),
                            f1("Store", 17, color: black)
                          ],
                        ),
                      ),
                    ),

// entertainment section
                    Container(
                      color: const Color(0xff21C8F6).withOpacity(0.1),
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 2.25,
                      height: MediaQuery.of(context).size.width / 2.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.view_carousel_outlined,
                            size: 70,
                            color: Color(0xff21C8F6).withOpacity(0.3),
                          ),
                          f1("Entertainment", 17, color: black)
                        ],
                      ),
                    ),

// news section
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Newspage()),
                      ),
                      child: Container(
                        color: const Color(0xff4CD964).withOpacity(0.1),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width / 2.25,
                        height: MediaQuery.of(context).size.width / 2.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.newspaper_rounded,
                              size: 70,
                              color: const Color(0xff4CD964).withOpacity(0.3),
                            ),
                            f1("News", 17, color: black)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget weather(date) {
  return Container(
    padding: const EdgeInsets.all(20),
    // margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
      color: white,
      image: const DecorationImage(
        image: AssetImage("assets/img/ecoweather.png"),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // weather reading
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                f6("45°C", 20, color: black),
                f1("Abuja, Ng", 10, color: black)
              ],
            ),
            f7(date, 12, color: black)
          ],
        ),

        // description
        f5("Cloudy weather, good for work", 13, color: deepgreen)
      ],
    ),
  );
}

Widget entertainments(context) {
  return Container(
    padding: const EdgeInsets.all(20),
    // margin: const EdgeInsets.all(10),
    width: double.infinity,
    height: 140,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white,
      image: const DecorationImage(
        image: AssetImage("assets/img/ecoenter.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                f6("Entertainment", 15, color: deepgreen),
                f6("Have fun on a trip to changing the world", 13,
                    color: black),
              ],
            ))
      ],
    ),
  );
}

Widget store(context) {
  return InkWell(
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Store())),
    child: Container(
      padding: const EdgeInsets.all(20),
      // margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
        image: const DecorationImage(
          image: AssetImage("assets/img/ecocart.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  f6("Online store", 15, color: deepgreen),
                  f6("Shop with your coin today", 13, color: black),
                ],
              ))
        ],
      ),
    ),
  );
}

Widget news(context) {
  return InkWell(
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Newspage())),
    child: Container(
      padding: const EdgeInsets.all(20),
      // margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
        image: const DecorationImage(
          image: AssetImage("assets/img/econews.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                f6("News", 15, color: deepgreen),
                f6("Shop with your coin today", 13, color: black),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
