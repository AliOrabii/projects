import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shop_clone/classes/item.dart';
import 'package:shop_clone/classes/order.dart';
import 'package:shop_clone/classes/user.dart';
import 'package:shop_clone/providers/cart.dart';

class orders with ChangeNotifier {
  List<order> _OrderItems = [];

  final String? token;

  orders(this.token, this._OrderItems);

  List<order> get OrderItems {
    return _OrderItems;
  }

  Future<void> addorder(order order) async {
    final Url = Uri.parse(
        'https://shop-clone-95314-default-rtdb.firebaseio.com/orders.json?auth=$token');
    try {
      final response = await http
          .post(Url,
              body: json.encode(
                {
                  'DateCreated': order.DateCreated,
                  'total': order.total,
                  'status': order.status.toString(),
                  'orderItems': order.CartItems.map((e) => {
                        'id': e.id,
                        'title': e.title,
                        'price': e.price,
                        'quantity': e.quantity,
                        'size': e.Size,
                        'imageUrl': e.imageUrl,
                        'category': e.Category,
                        'isFav': e.isfavorite,
                      }).toList(),
                  'user': order.user.map(),
                },
              ))
          .then((response) {
        _OrderItems.add(order);
        notifyListeners();
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchdata() async {
    final Url = Uri.parse(
        'https://shop-clone-95314-default-rtdb.firebaseio.com/orders.json?auth=$token');
    final List<order> loadedorders = [];
    try {
      final response = await http.get(Url);
      final extractedData = json.decode(response.body) ?? <String, dynamic>{};
      if (extractedData == null) return;
      extractedData.forEach((orderId, orderData) {
        order NewOrder = order(
          orderData['DateCreated'],
          (orderData['orderItems'] as List<dynamic>)
              .map(
                (e) => Item(
                  id: e['id'],
                  title: e['title'],
                  Category: e['category'],
                  imageUrl: e['imageUrl'],
                  price: e['price'],
                ),
              )
              .toList(),
        );
        NewOrder.total = orderData['total'];
        NewOrder.id = orderId;
        NewOrder.user = UserInfo(
          orderData['user']['firstname'],
          orderData['user']['lastname'],
          orderData['user']['username'],
          orderData['user']['password'],
          orderData['user']['addressinfo'],
          orderData['user']['country'],
          orderData['user']['state'],
          orderData['user']['city'],
          orderData['user']['phonenumber'],
        );
        String x = orderData['status'].toString();
        String y = x.split('.').last;
        NewOrder.status = OrderStatus.values.byName(y);
        loadedorders.add(NewOrder);
      });

      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
    _OrderItems = loadedorders.reversed.toList();
  }

  void removeorder(order order) {
    _OrderItems.removeWhere((element) => element.id == order.id);
    notifyListeners();
  }
}
