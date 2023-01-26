import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_clone/classes/order.dart';
import 'package:shop_clone/providers/cart.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/providers/orders.dart';
import 'package:shop_clone/screens/shop_screen.dart';
import 'package:shop_clone/screens/user_info_screen.dart';
import 'package:shop_clone/widgets/address_details.dart';
import 'package:shop_clone/widgets/order_details.dart';

class ConfirmationScreen extends StatelessWidget {
  static const routeName = '/Confirm-screen';

  Widget RowDisplay(String title, double val, double size, Color color) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 8, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${title}:  ',
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'EGP ${val}',
            style: TextStyle(
                fontSize: size, fontWeight: FontWeight.w800, color: color),
          ),
        ],
      ),
    );
  }

  Widget TextDisplay(String title, double size, FontWeight fontWeight) {
    return Text(
      title,
      style: TextStyle(fontSize: size, fontWeight: fontWeight),
    );
  }

  Widget Space(double x) {
    return SizedBox(
      height: x,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Neworder = ModalRoute.of(context)!.settings.arguments as order;
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 235, 235),
      appBar: AppBar(
        title: Text('Confirm your Order'),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed(UserInfoScreen.routeName),
          icon: Icon(Icons.adaptive.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextDisplay('ADDRESS DETAILS', 17, FontWeight.w700),
            Space(4),
            AddressDetails(Neworder, true),
            Space(6),
            TextDisplay('ORDER DETAILS', 17, FontWeight.w700),
            Space(6),
            OrderDetails(Neworder),
            Space(6),
            TextDisplay('CHECKOUT DETAILS', 17, FontWeight.w700),
            Space(6),
            Material(
              elevation: 10,
              child: Container(
                height: 200,
                color: Colors.white,
                child: Column(
                  children: [
                    Space(4),
                    RowDisplay('Subtotal', cart.Subtotal, 18, Colors.black),
                    RowDisplay('Shipping', cart.shipping, 16, Colors.black),
                    RowDisplay('Tax', double.parse(cart.Tax.toStringAsFixed(2)),
                        16, Colors.black),
                    Space(20),
                    Divider(
                      color: Colors.black,
                      height: 2,
                      indent: 12,
                      endIndent: 12,
                      thickness: 1.2,
                    ),
                    RowDisplay(
                        'Total', cart.total, 20, Colors.deepPurple.shade800),
                    SizedBox(
                      width: 350,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                          ),
                          onPressed: () async {
                            Neworder.status = OrderStatus.Preparing;
                            Neworder.total = cart.total;
                            final response = await Provider.of<orders>(context,
                                    listen: false)
                                .addorder(Neworder)
                                .then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: (Text('Order added')),
                              ));
                              //cart.clearItems();
                              Navigator.pushReplacementNamed(
                                  context, ShopScreen.routeName);
                            });
                          },
                          child: Text('PLACE ORDER')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
