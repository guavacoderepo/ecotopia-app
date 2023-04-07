import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/constants/font.dart';
import 'package:technovationapp/modules/checkout.dart';
import 'package:technovationapp/modules/deletecart.dart';
import 'package:technovationapp/modules/storepayclass.dart';
import 'package:technovationapp/modules/usersclass.dart';
import 'package:technovationapp/utilities/variables.dart';
import '../constants/colors.dart';
import 'package:uuid/uuid.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  String total = "0";
  String? token = "";
  int rebuild = 0;
  bool canClose = true;

  @override
  void initState() {
    setState(() {
      token = Uuid().v4();
    });
    // print(token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Usersclass user = Provider.of<Users>(context, listen: true).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: f5("${user.data.username} Cart", 16),

        // cart icon
        actions: [
          //  total cart item
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 15),
            child: Badge(
              label: Text(user.data.cart.length.toString()),
              backgroundColor: deepgreen,
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: blacklight,
              ),
            ),
          ),
          // total cart price
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 6),
            child: f1("∆$total", 15, color: blacklight),
          ),
          // payment button
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.center,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: deepgreen,
                  iconColor: white,
                ),
                onPressed: user.data.cart.isEmpty
                    ? null
                    : () async => paymentdialog(user.data.address, token),
                icon: const Icon(Icons.payment),
                label: f5("Pay", 14, color: white),
              ),
            ),
          )
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

// cart body
      body: FutureBuilder<Cartclass>(
        // future builder
        future: checkoutcart(user.data.address),
        builder: (context, snap) {
          if (snap.hasData) {
            // create data
            var data = snap.data!.data;
            rebuild == 0
                ? Future.delayed(Duration.zero, () {
                    setState(() {
                      // print("rebuild");
                      total = snap.data!.price.toStringAsFixed(2);
                    });
                  })
                : null;
// check if cart is empty
            if (user.data.cart.isEmpty) {
              return Center(
                child: Image.asset("assets/emptycart.webp"),
              );
// if cart id not empty render future builder
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: lightwhite,
                ),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  // build the containers
                  return Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.08,
                        right: MediaQuery.of(context).size.width * 0.08),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: white,
                      child: Column(
                        children: [
                          Image.network(
                            data[i].imgUrl,
                            height: 150,
                          ),
                          vgap(10),
                          Row(
                            children: [
                              f5("Category: ", 14, color: deepgreen),
                              f1(data[i].category, 14, color: black)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              f5("Title: ", 14, color: deepgreen),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: f1(data[i].title, 14, color: black),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              f5("Quantity: ", 14, color: deepgreen),
                              f1(data[i].quantity.toString(), 14, color: black),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              f5("Price: ", 14, color: deepgreen),
                              f1("∆${data[i].price.toStringAsFixed(2)}", 14,
                                  color: black),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                iconColor: white,
                              ),
                              // add to cart function
                              onPressed: () async => await deletedialog(
                                  user.data.address, data[i].id),
                              icon: const Icon(Icons.delete),
                              label: f5("Remove from cart", 14, color: white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // build the cart
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: deepgreen,
              ),
            );
          }
        },
      ),
    );
  }

// delete item from cart
  Future deletedialog(userid, productid) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: f1('Delete cart item', 15, color: black),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                f1('Are you sure you want to delete this item?', 13,
                    color: black),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: f1("Yes", 14, color: deepgreen),
              onPressed: () async {
                delete(userid, productid);
              },
            ),
          ],
        );
      },
    );
  }

  // delete item from cart
  Future paymentdialog(address, token) async {
    return showDialog(
      context: context,
      barrierDismissible: canClose,
      builder: (context) {
        return AlertDialog(
          title: f1('proceed with payment', 15, color: black),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                f1('Are you sure you want to pay this item?', 13, color: black),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: f1("Yes", 14, color: deepgreen),
              onPressed: () async {
                // close and make payment
                Navigator.pop(context);
                paying(address, token);
              },
            ),
          ],
        );
      },
    );
  }

  Future paying(address, token) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            color: white,
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              color: deepgreen,
              strokeWidth: 1,
            ),
          ),
        );
      },
    );
    await makepayment(address, token).then(
      (value) {
        if (value["status"] == true) {
          Provider.of<Users>(context, listen: false).users(username: address);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: f5("payment successful", 12, color: white),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: f5(value["message"], 12, color: white),
            ),
          );
        }
      },
    );
    Navigator.pop(context);
    setState(() => canClose = true);
  }

  Future delete(userid, productid) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            color: white,
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              color: deepgreen,
              strokeWidth: 1,
            ),
          ),
        );
      },
    );

    await deletecart(userid, productid).then((value) {
      if (value["status"] == true) {
        Provider.of<Users>(context, listen: false).users(username: userid);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Cart()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: f5(value["message"], 12, color: white),
          ),
        );
      }
    });

    Navigator.pop(context);
    Navigator.pop(context);
    setState(() => canClose = true);
  }
  // make payment
}
