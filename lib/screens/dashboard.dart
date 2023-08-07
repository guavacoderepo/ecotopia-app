import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/constants/colors.dart';
import 'package:technovationapp/utilities/font.dart';
import 'package:technovationapp/modules/usersclass.dart';
import 'package:technovationapp/screens/bankpayment.dart';
import 'package:technovationapp/screens/donate.dart';
import 'package:technovationapp/screens/footprint.dart';
import 'package:technovationapp/screens/news.dart';
import 'package:technovationapp/screens/profile.dart';
import 'package:technovationapp/screens/store.dart';
import 'package:technovationapp/utilities/variables.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';
import 'package:url_launcher/url_launcher.dart';

List<CameraDescription> cameras = [];

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
// camera func
  final Uri _url = Uri.parse('https://b-u-b-e.itch.io/ecotopia');
  Future cameraDetection() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Footprint(cameras),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    Usersclass user = Provider.of<Users>(context).user;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE d MMMM, y').format(now);
    return Scaffold(
      // backgroundColor: lightwhite,
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: text("Hello, ${user.data!.username}", 16, color: black),
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: PopupMenuButton(
        //       offset: const Offset(0, 5),
        //       itemBuilder: (context) => [
        //         PopupMenuItem(
        //           value: 1,
        //           child: f1("About", 13, color: black),
        //         ),
        //         PopupMenuItem(
        //           value: 2,
        //           child: f1("Privacy policy", 13, color: black),
        //         ),
        //         PopupMenuItem(
        //           value: 3,
        //           child: f1("Logout", 13, color: black),
        //         ),
        //       ],
        //       child: const Icon(
        //         IconlyLight.setting,
        //         color: deepgreen,
        //       ),
        //     ),
        //   )
        // ],
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
                        f1("∆${user.data!.balance!.toStringAsFixed(2)}", 23,
                            color: black),
                        Flexible(
                          child: f1(user.data!.address, 10, color: black),
                        ),
                      ],
                    ),

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
                  ],
                ),
              ),
              vgap(10),
              // top card ends here

              weather(formattedDate),

              vgap(20),

              StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  cardDesign(
                    context,
                    const Color(0xff637BFF),
                    "Footprint",
                    Icons.calculate_outlined,
                    () => cameraDetection(),
                  ),
// footprint section
                  cardDesign(
                    context,
                    const Color(0xffF19A1A),
                    "Store",
                    Icons.shopping_cart_outlined,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Store(),
                      ),
                    ),
                  ),
// enterntainment section
                  cardDesign(
                    context,
                    const Color(0xff21C8F6),
                    "Entertainment",
                    Icons.queue_music_rounded,
                    () => _launchUrl(),
                  ),
// news section
                  cardDesign(
                    context,
                    const Color(0xff4CD964),
                    "News",
                    Icons.newspaper_rounded,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Newspage(),
                      ),
                    ),
                  )
                ],
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
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/img/ecoweather.png"),
        fit: BoxFit.cover,
      ),
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

cardDesign(context, Color color, title, IconData icon, Function callback) =>
    InkWell(
      onTap: () async => callback(),
      child: Container(
        decoration: BoxDecoration(
          // color: color.withOpacity(0.2),
          border: Border.all(
            color: const Color(0xffCDD2DE),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 2.25,
        height: MediaQuery.of(context).size.width / 2.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 70,
              color: color.withOpacity(0.5),
            ),
            f1(title, 17, color: black)
          ],
        ),
      ),
    );
