import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './cart.dart';
import 'package:provider/provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<dynamic> _orders = [];
  final String authtoken;
  final String userID;

  Orders(this.authtoken, this.userID, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final Url = Uri.parse(
        'https://flutter-update-35fd7-default-rtdb.firebaseio.com/orders/$userID.json?auth=$authtoken');
    final loadedOrders = [];
    try {
      final response = await http.get(Url);
      final extractedData = json.decode(response.body) ?? <String, dynamic>{};
      if (extractedData == null) return;
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          id: orderId,
          dateTime: DateTime.parse(orderData['dateTime']),
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } on Exception catch (e) {
      throw (e);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final Url = Uri.parse(
        'https://flutter-update-35fd7-default-rtdb.firebaseio.com/orders/$userID.json?auth=$authtoken');
    final timestamp = DateTime.now();
    try {
      final response = await http
          .post(Url,
              body: json.encode({
                'amount': total,
                'dateTime': timestamp.toIso8601String(),
                'products': cartProducts
                    .map(
                      (e) => {
                        'id': e.id,
                        'title': e.title,
                        'price': e.price,
                        'quantity': e.quantity,
                      },
                    )
                    .toList(),
              }))
          .then((response) {
        _orders.insert(
          0,
          new OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now(),
          ),
        );
        notifyListeners();
      });
    } catch (e) {
      throw (e);
    }
  }
}
