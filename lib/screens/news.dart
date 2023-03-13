import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/font.dart';

class Newspage extends StatefulWidget {
  const Newspage({super.key});

  @override
  State<Newspage> createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  var title = [
    "UK forests lock away twice as much planet-warming carbon as previously thought, a new study reveals",
    "Next year will be warmer than this one, and one of the hottest on record, the UK Met Office is forecasting",
    "'The bears know the ice will be back soon - they're waiting,' says Alysa McCall, from Polar Bears International (PBI)",
    "Parts of a new Welsh law banning some single-use plastics may not be in full effect until 2026, a senior Senedd member has said.",
    "The Arctic is getting wetter."
  ];
  var description = [
    "The study using lasers and 3D scanning showed that old trees in particular were critical to fighting climate change. The research mapped almost 1,000 trees in Wytham Wood in Oxfordshire.",
    "Predictions suggest it will be the 10th year in a row the global temperature is at least 1C above average.",
    "Alysa and her team are in the Canadian Arctic just outside Churchill, Manitoba, in a tundra buggy - an observation lab on tracks, which allows them to watch bears in safety.",
    "The Welsh Parliament passed a law banning a range of items last week.Some of them will be banned in autumn 2023 but other items - including on carrier bags - will be outlawed later to allow firms to use up stock.The Welsh government has not given a date but Labour's Huw Irranca Davies suggested a delay until 2026.",
    "For a long time scientists could identify no trends in the amount of snow, rain and freezing rain across the region, but that's now changed."
  ];
  var url = [
    "https://www.bbc.com/news/science-environment-64028694",
    "https://www.bbc.com/news/science-environment-64032458",
    "https://www.bbc.com/news/science-environment-63603489",
    "https://www.bbc.com/news/uk-wales-politics-63880012",
    "https://www.bbc.com/news/science-environment-63967630"
  ];
  var src = [
    "Times news",
    "Angel Odyssey",
    "Plus dayNews",
    "Fortun Odyssey",
    "Sunna news"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: f5("Cimate News", 16),

        // cart icon

// pop icon
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: deepgreen,
          ),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Color.fromARGB(255, 62, 62, 62),
        ),
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            // image section
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: 100,
                  child: Image.asset(
                    "assets/news/n${i + 1}.jpg",
                    fit: BoxFit.cover,
                    height: 100,
                  ),
                ),
                const SizedBox(width: 10),
                // descriptin
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // news short description
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.1,
                      child: f6(title[i], 12, color: black),
                    ),
                    f7("bbc.com", 11, color: deepgreen),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
