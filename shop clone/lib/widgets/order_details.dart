import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/classes/order.dart';
import 'package:shop_clone/providers/cart.dart';
import 'package:shop_clone/providers/orders.dart';
import 'dart:math';

class OrderDetails extends StatelessWidget {
  order Neworder;

  OrderDetails(this.Neworder);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Material(
      elevation: 10,
      child: Container(
        height: min(cart.CartItems.length * 100, 270),
        color: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          itemCount: cart.CartItems.length,
          itemBuilder: (ctx, i) {
            return SizedBox(
              height: 80,
              child: Dismissible(
                onDismissed: ((direction) {
                  cart.removeitem(cart.CartItems[i]);
                }),
                key: ValueKey(cart.CartItems[i].id),
                dragStartBehavior: DragStartBehavior.start,
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: null,
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                child: Card(
                  elevation: 6,
                  child: ListTile(
                    leading: SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 23,
                            backgroundImage:
                                NetworkImage(cart.CartItems[i].imageUrl),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      cart.CartItems[i].title,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    subtitle: Text(
                      'Size: ${cart.CartItems[i].Size}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${cart.CartItems[i].quantity}x',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5)),
                          Text(
                            '${cart.CartItems[i].price * cart.CartItems[i].quantity}\$',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
