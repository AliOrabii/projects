import 'package:flutter/cupertino.dart';
import 'package:shop_clone/classes/item.dart';

class Cart with ChangeNotifier {
  final List<Item> _CartItems = [];

  List<Item> get CartItems {
    return _CartItems;
  }

  int get itemsCount {
    int x = 0;
    _CartItems.forEach((element) {
      x += element.quantity;
    });
    return x;
  }

  double get Subtotal {
    double x = 0;
    _CartItems.forEach((element) {
      x += (element.quantity * element.price);
    });

    return x;
  }

  double get Tax {
    double x = Subtotal;
    x = x * 0.14;
    return double.parse(x.toStringAsFixed(2));
  }

  double get shipping {
    double x = Subtotal;
    x = x * 0.35;
    return double.parse(x.toStringAsFixed(2));
  }

  double get total {
    double x = Subtotal;
    x += Tax;
    x += shipping;
    return x;
  }

  void update_quantity(String id, int value) {
    Item item = _CartItems.firstWhere((element) => element.id == id);
    item.quantity = value;
    notifyListeners();
  }

  void additem(Item item) {
    if (_CartItems.contains(item)) {
      item.quantity++;
    } else {
      _CartItems.add(item);
    }
    notifyListeners();
  }

  void removeitem(Item item) {
    _CartItems.remove(item);
    notifyListeners();
  }

  void clearItems() {
    _CartItems.clear();
    notifyListeners();
  }
}
