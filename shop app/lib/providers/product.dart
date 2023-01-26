import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavorite = false;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isfavorite = false,
  });

  Future<void> togglefavorite(String id, Product product) async {
    final Url = Uri.parse(
        'https://flutter-update-35fd7-default-rtdb.firebaseio.com/products/$id.json');
    http.patch(Url, body: json.encode({'isFavorite': product.isfavorite}));
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldstatus = isfavorite;
    isfavorite = !isfavorite;
    notifyListeners();
    final Url = Uri.parse(
        'https://flutter-update-35fd7-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        Url,
        body: json.encode(
          isfavorite,
        ),
      );
      if (response.statusCode >= 400) {
        isfavorite = oldstatus;
        notifyListeners();
      }
    } catch (e) {
      isfavorite = oldstatus;
      notifyListeners();
    }
  }
}
