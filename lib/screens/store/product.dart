import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/models/store.model.dart';
import 'package:technovationapp/models/user.model.dart';
import 'package:technovationapp/utilities/font.dart';
import 'package:technovationapp/utilities/variables.dart';
import '../../constants/colors.dart';
import '../../requestmodels/addcart.dart';
import '../../requestmodels/usersclass.dart';
import 'cart.dart';

class Product extends StatefulWidget {
  final Item item;

  const Product(this.item, {super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    Usersclass user = Provider.of<Users>(context, listen: true).user;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        title: f5(widget.item.category, 16),

        // cart icon
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 15),
            child: InkWell(
              child: Badge(
                label: Text(user.data!.cart!.length.toString()),
                backgroundColor: deepgreen,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: blacklight,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ),
              ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06,
              right: MediaQuery.of(context).size.width * 0.06),
          child: Column(
            children: [
              // product image
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.3,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/cart.png",
                  image: widget.item.imgUrl,
                  fit: BoxFit.cover,
                ),
              ),

              // product
              vgap(5),
              Align(
                alignment: Alignment.topLeft,
                child: f6(widget.item.category, 19),
              ),
              vgap(5),
              // titlee
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: f1(widget.item.title, 14, color: textgrey),
              ),
              vgap(5),
              // quantity and price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
// quantity  bar
                  Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: deepgreen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
// subtract quantity on minus pressed
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity -= 1;
                              if (quantity < 1) {
                                quantity = 1;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: white,
                          ),
                        ),
// quantity text
                        f5(quantity.toString(), 15, color: white),
// add icon button
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity += 1;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // product price

                  f1("∆ ${widget.item.price}", 16, color: black)
                ],
              ),
              // description
              vgap(10),
              Align(
                alignment: Alignment.topLeft,
                child: f5("About the product", 15),
              ),

              vgap(5),
              Align(
                alignment: Alignment.topLeft,
                child: f1(widget.item.description, 12, color: black),
              ),
              vgap(10),

              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: lightwhite,
                    iconColor: deepgreen,
                  ),
                  // add to cart function
                  onPressed: () async {
                    cart(user.data!.username, widget.item.id, quantity)
                        .then((value) {
                      users(context).then((value) {
                        // diaplay added when added to cart successful
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: f5("Added to cart", 12, color: white),
                          ),
                        );
                      });
                    });
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: f5("Add to cart", 14, color: deepgreen),
                ),
              ),
              vgap(20)
            ],
          ),
        ),
      ),
    );
  }
}
