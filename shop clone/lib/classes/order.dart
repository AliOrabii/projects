import 'package:flutter/material.dart';
import 'package:shop_clone/classes/item.dart';
import 'package:shop_clone/classes/user.dart';
import 'package:shop_clone/providers/cart.dart';
import 'package:shop_clone/providers/items.dart';

enum OrderStatus { Delieverd, Shipped, Preparing, WaitingForConfirmation }

class order {
  String id = '';
  final String DateCreated;
  double total = 0;
  OrderStatus status = OrderStatus.WaitingForConfirmation;
  final List<Item> CartItems;
  UserInfo user = UserInfo('', '', '', '', '', '', '', '', '');

  order(
    this.DateCreated,
    this.CartItems,
  );

  double get Subtotal {
    double x = 0;
    CartItems.forEach((element) {
      x += element.quantity * element.price;
    });
    return x;
  }

  double get Tax {
    double x = Subtotal * 0.14;
    return x;
  }

  double get shipping {
    double x = Subtotal;
    x = x * 0.35;
    return double.parse(x.toStringAsFixed(2));
  }
}
