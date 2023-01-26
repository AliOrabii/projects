import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_clone/classes/order.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DialogOrderDetails extends StatelessWidget {
  order Neworder;
  DialogOrderDetails(this.Neworder);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(8),
        height: min(Neworder.CartItems.length * 90, 270),
        child: ListView.builder(
          itemCount: Neworder.CartItems.length,
          itemBuilder: (context, i) => Card(
            elevation: 6,
            child: ListTile(
              leading: SizedBox(
                width: 40,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(Neworder.CartItems[i].imageUrl),
                ),
              ),
              title: Text(
                Neworder.CartItems[i].title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${Neworder.CartItems[i].Category}, ${Neworder.CartItems[i].Size}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              trailing: SizedBox(
                width: 56,
                child: Row(
                  children: [
                    Text('${Neworder.CartItems[i].quantity}x',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5)),
                    Text(
                      '${Neworder.CartItems[i].price * Neworder.CartItems[i].quantity}\$',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
