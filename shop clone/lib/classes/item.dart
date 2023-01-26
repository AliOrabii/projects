import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/providers/items.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Item with ChangeNotifier {
  String id;
  final String title;
  final String Category;
  final String imageUrl;
  final double price;
  String Size = 'XS';
  int quantity = 1;
  bool isfavorite;

  Item({
    required this.id,
    required this.title,
    required this.Category,
    required this.imageUrl,
    required this.price,
    this.isfavorite = false,
  });
}
