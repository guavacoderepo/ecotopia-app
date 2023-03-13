import 'package:flutter/material.dart';
import 'package:technovationapp/constants/colors.dart';
import 'package:technovationapp/constants/font.dart';
import 'package:technovationapp/utilities/variables.dart';

class Contribute extends StatelessWidget {
  const Contribute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: f7("How to Contribute", 16, color: deepgreen),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: deepgreen,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              f6("Step one:", 15),
              f1("asyncInitState() executes only when widget is build. inside in initState. NepoKale.",
                  13,
                  color: blacklight),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  "https://previews.agefotostock.com/previewimage/medibigoff/74a269a72d202b8e64b233c15e1a7b71/esy-060146802.jpg",
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              f6("Step Two:", 15),
              f1("asyncInitState() executes only when widget inside in initState. NepoKale.",
                  13,
                  color: blacklight),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  "https://cdn5.vectorstock.com/i/1000x1000/28/94/young-people-in-outlet-shop-purchasing-clothes-vector-34502894.jpg",
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              f6("Step Three:", 15),
              f1("asyncInitState() executes only when widgetinside in initState. NepoKale.",
                  13,
                  color: blacklight),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzuqgNYQreufRS9crBWJv73rjLpRE1wH_h_w&usqp=CAU",
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              f6("Step Four:", 15),
              f1("asyncInitState() executes only when widget inside in initState. NepoKale.",
                  13,
                  color: blacklight),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  "https://cdn.xxl.thumbs.canstockphoto.com/fashion-brand-outlet-landing-page-template-cheerful-shopaholic-girls-purchase-clothes-happy-women-eps-vectors_csp90179039.jpg",
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              f6("Step Five:", 15),
              f1("asyncInitState() executes only when widget inside in initState. NepoKale.",
                  13,
                  color: blacklight),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLPFdg1gDrUPjctIjbTDqrrYmtrIRCbOu46w&usqp=CAU",
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              vgap(10)
            ],
          ),
        ),
      ),
    );
  }
}
