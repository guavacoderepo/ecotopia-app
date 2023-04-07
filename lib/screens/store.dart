import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/constants/colors.dart';
import 'package:technovationapp/constants/font.dart';
import 'package:technovationapp/modules/addcart.dart';
import 'package:technovationapp/modules/storeclass.dart';
import 'package:technovationapp/modules/usersclass.dart';
import 'package:technovationapp/screens/cart.dart';
import 'package:technovationapp/screens/product.dart';
import 'package:technovationapp/utilities/variables.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    Usersclass user = Provider.of<Users>(context, listen: true).user;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: transparent,
          elevation: 0,
          // title: SizedBox(
          //   height: 35,
          //   // search filed
          //   child: TextField(
          //     style: const TextStyle(fontSize: 15, color: blacklight),
          //     decoration: InputDecoration(
          //       contentPadding: const EdgeInsets.all(2),
          //       enabledBorder: const OutlineInputBorder(
          //         borderSide:
          //             BorderSide(color: Color.fromARGB(255, 119, 118, 118)),
          //       ),
          //       focusedBorder: const OutlineInputBorder(
          //         borderSide:
          //             BorderSide(color: Color.fromARGB(115, 104, 103, 103)),
          //       ),
          //       prefixIcon: IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           IconlyLight.search,
          //           color: blacklight,
          //           size: 20,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // arrow back
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: deepgreen,
            ),
          ),
          // search, cart and price section
          actions: [
            // cart items and button
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 15),
              child: InkWell(
                child: Badge(
                  label: Text(user.data.cart.length.toString()),
                  backgroundColor: deepgreen,
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: blacklight,
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(),
                  ),
                ),
              ),
            ),
            // total cart price
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 15),
              child: f1("∆${user.data.balance.toStringAsFixed(2)}", 15,
                  color: blacklight),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          // store list view body
          child: FutureBuilder<StoreClass>(
            future: storedata(),
            builder: (context, snap) {
              if (snap.hasData) {
                return GridView.builder(
                  itemCount: snap.data!.data.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisExtent: 260,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, i) {
                    // create instabce of snap data
                    var data = snap.data!.data;
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Product(data[i]))),
                      child: Container(
                        color: white,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // product image
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.1,
                              height: 130,
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/cart.png",
                                image: data[i].imgUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Divider(color: deepgreen),
                            // const SizedBox(width: 10),
                            Row(
                              children: [
                                f6(data[i].category, 10, color: deepgreen),
                                Expanded(child: Container()),
                                f6("${data[i].quantity} stock", 10,
                                    color: Colors.red),
                              ],
                            ),
                            vgap(5),
                            // description
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.25,
                              child: f5(
                                // if text is graeter than 20 shrten it
                                data[i].description.length > 20
                                    ? "${data[i].description.substring(0, 17)}..."
                                    : data[i].description,
                                12,
                                color: blacklight,
                              ),
                            ),

                            // cost and quantity
                            Row(
                              children: [
                                f5("∆ ${data[i].price.toString()}", 15,
                                    color: black),
                                Expanded(child: Container()),
                                MaterialButton(
                                    minWidth: 5,
                                    color: deepgreen,
                                    onPressed: () async {
                                      cart(user.data.address, data[i].id, 1)
                                          .then((value) {
                                        Provider.of<Users>(context,
                                                listen: false)
                                            .users(username: user.data.address);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: f5("Added to cart", 12,
                                                color: white),
                                          ),
                                        );
                                      });
                                    },
                                    child: const Icon(Icons.add, color: white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: deepgreen,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
