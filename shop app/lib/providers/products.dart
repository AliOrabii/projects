import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/http_exception.dart';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);
  List<Product> get items {
    return [..._items];
  }

  List<Product> get Favitems {
    return _items.where((prodItme) => prodItme.isfavorite).toList();
  }

  Future<void> fetchData([bool filterByUser = false]) async {
    var filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://flutter-update-35fd7-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString');

    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) return;
    try {
      url = Uri.parse(
          'https://flutter-update-35fd7-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isfavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-update-35fd7-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http
          .post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      )
          .then((response) {
        final newProduct = Product(
            id: json.decode(response.body)['name'],
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl);
        _items.add(newProduct);
        notifyListeners();
      });
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProducts(String id, Product newProd) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-update-35fd7-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'title': newProd.title,
            'description': newProd.description,
            'imageUrl': newProd.imageUrl,
            'price': newProd.price,
          }));
      _items[prodIndex] = newProd;

      notifyListeners();
    } else {
      print('...');
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> deleteProd(String id) async {
    final url = Uri.parse(
        'https://flutter-update-35fd7-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    final existingProdIndex = _items.indexWhere((element) => element.id == id);
    var existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProd);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProd = null;
  }
}
