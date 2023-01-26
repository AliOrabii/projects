import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_clone/classes/order.dart';
import 'package:shop_clone/widgets/address_details.dart';
import 'package:shop_clone/widgets/dialog/checkout_details.dart';
import '../dialog/dialog_order_details.dart';

class CustomDialog extends StatelessWidget {
  order Neworder;
  CustomDialog(this.Neworder);

  Widget title(String name, double size, FontWeight weight) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.5),
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: weight,
          fontSize: size,
        ),
      ),
    );
  }

  Widget Space(double x) {
    return SizedBox(
      height: x,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      content: Container(
        height: (MediaQuery.of(context).size.height * 0.5) +
            min(Neworder.CartItems.length * 100, 190),
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Address Details', 16, FontWeight.w600),
            Space(4),
            AddressDetails(Neworder, false),
            Space(6),
            title('Order Details', 16, FontWeight.w600),
            Space(4),
            DialogOrderDetails(Neworder),
            Space(6),
            title('Checkout Details', 16, FontWeight.w600),
            Space(6),
            CheckoutDetails(Neworder),
            Space(20),
          ],
        ),
      ),
    );
  }
}
