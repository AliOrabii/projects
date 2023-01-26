import 'package:flutter/material.dart';
import 'package:shop_clone/classes/order.dart';

class CheckoutDetails extends StatelessWidget {
  order Neworder;
  CheckoutDetails(this.Neworder);

  Widget RowDisplay(String title, double val, double size, Color color) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 8, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${title}:  ',
            style: TextStyle(
              fontSize: size + 1,
              fontWeight: FontWeight.w600,
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

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowDisplay('SubTotal', Neworder.Subtotal, 16, Colors.black),
            RowDisplay('Shipping', Neworder.shipping, 16, Colors.black),
            RowDisplay('Tax', Neworder.Tax.roundToDouble(), 16, Colors.black),
            Divider(
                color: Colors.black,
                height: 2,
                indent: 12,
                endIndent: 12,
                thickness: 1.2),
            RowDisplay('Total', Neworder.total, 18, Colors.purple),
          ],
        ),
      ),
    );
  }
}
