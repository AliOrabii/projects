import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/classes/order.dart';
import 'package:shop_clone/classes/user.dart';
import 'package:shop_clone/providers/orders.dart';
import '../providers/cart.dart';
import '../screens/user_info_screen.dart';
import '../widgets/appDrawer.dart';
import '../widgets/cart_screen_item.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/Cart_Screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget RowDisplay(String title, double val, double fnt) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 8, right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${title}:  ',
            style: TextStyle(fontSize: fnt, fontWeight: FontWeight.w700),
          ),
          Text(
            '${val}EGP',
            style: TextStyle(fontSize: fnt, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartdata = Provider.of<Cart>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Bag'),
        actions: [
          Stack(children: [
            Positioned(
              top: 6,
              left: 12,
              child: Text(
                '${cartdata.itemsCount}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                onPressed: () => Navigator.pushReplacementNamed(
                    context, CartScreen.routeName),
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ]),
        ],
        centerTitle: true,
        shadowColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: cartdata.CartItems.isEmpty
          ? const Center(
              child: Text(
                'Your Bag in Empty!!!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            )
          : Column(
              children: [
                Container(
                  color: const Color.fromARGB(255, 246, 247, 247),
                  padding: const EdgeInsets.all(8),
                  height: 40,
                  width: double.infinity,
                  child: const Text(
                    'Cart Summary',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: cartdata.CartItems.length >= 2
                        ? 380
                        : (190.0 * cartdata.CartItems.length),
                    child: ListView.builder(
                      itemBuilder: ((ctx, index) => CartScreenItem(
                            cartdata.CartItems[index],
                          )),
                      itemCount: cartdata.CartItems.length,
                    ),
                  ),
                ),
                if (cartdata.CartItems.isNotEmpty)
                  Container(
                    color: const Color.fromARGB(255, 246, 247, 247),
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 5),
                    height: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RowDisplay('Subtotal', cartdata.Subtotal, 16),
                        RowDisplay('Shipping', cartdata.shipping, 16),
                        RowDisplay('Tax', cartdata.Tax, 16),
                        RowDisplay('Total', cartdata.total, 22),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 3),
                          child: ElevatedButton(
                              onPressed: () {
                                order neworder = order(
                                    DateFormat.MEd().format(DateTime.now()),
                                    cartdata.CartItems);
                                Navigator.pushReplacementNamed(
                                    context, UserInfoScreen.routeName,
                                    arguments: neworder);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor),
                              ),
                              child: const Text(
                                'PROCEED TO CHECKOUT',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              )),
                        )
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
