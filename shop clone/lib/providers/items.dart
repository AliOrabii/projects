import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../classes/item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [
    // Item(
    //   id: '',
    //   title: 'Basic Shirt',
    //   Category: 'Top',
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0648/4531/6322/products/517945-HR-MB.jpg',
    //   price: 200,
    //   Size: 'XS',
    // ),
    // Item(
    //   id: '',
    //   title: 'Basic Shirt2',
    //   Category: 'Top',
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0648/4531/6322/products/517945-HR-MB.jpg',
    //   price: 200,
    //   Size: 'XS',
    // ),
    // Item(
    //   id: '',
    //   title: 'Basic Shirt3',
    //   Category: 'Top',
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0648/4531/6322/products/517945-HR-MB.jpg',
    //   price: 200,
    //   Size: 'XS',
    // ),
    // Item(
    //   id: '',
    //   title: 'Basic Shirt4',
    //   Category: 'Top',
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0648/4531/6322/products/517945-HR-MB.jpg',
    //   price: 200,
    //   Size: 'XS',
    // ),
    // Item(
    //   id: '',
    //   title: 'Basic Shirt5',
    //   Category: 'Top',
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0648/4531/6322/products/517945-HR-MB.jpg',
    //   price: 200,
    //   Size: 'XS',
    // ),
    // Item(
    //   id: '',
    //   title: 'Basic Shirt6',
    //   Category: 'Top',
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0648/4531/6322/products/517945-HR-MB.jpg',
    //   price: 200,
    //   Size: 'XS',
    // ),
    // Item(
    //   id: '',
    //   title: 'Basic Shirt7',
    //   Category: 'Top',
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0648/4531/6322/products/517945-HR-MB.jpg',
    //   price: 200,
    //   Size: 'XS',
    // ),
    // Item(
    //   id: '',
    //   title: 'Basic Shirt8',
    //   Category: 'Top',
    //   imageUrl:
    //       'https://cdn.shopify.com/s/files/1/0648/4531/6322/products/517945-HR-MB.jpg',
    //   price: 200,
    //   Size: 'XS',
    // ),
  ];
  final String? authToken;
  Items(this.authToken, this._items);

  List<Item> get items {
    return _items;
  }

  List<Item> get Favs {
    return _items.where((element) => element.isfavorite == true).toList();
  }

  Future<void> fetchdata() async {
    final Url = Uri.parse(
        'https://shop-clone-95314-default-rtdb.firebaseio.com/items.json?auth=$authToken');
    final response = await http.get(Url);
    final ExtractedData = json.decode(response.body) as Map<String, dynamic>;
    if (ExtractedData == null) return;
    try {
      final List<Item> loadedProducts = [];
      ExtractedData.forEach((itemId, itemData) {
        loadedProducts.add(
          Item(
            id: itemId,
            title: itemData['title'],
            Category: itemData['category'],
            imageUrl: itemData['imageUrl'],
            isfavorite: itemData['isFavorite'],
            price: itemData['price'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> additems() async {
    final Url = Uri.parse(
        'https://shop-clone-95314-default-rtdb.firebaseio.com/items.json');
    try {
      items.forEach((element) async {
        final response = await http
            .post(
          Url,
          body: json.encode(
            {
              'imageUrl': element.imageUrl,
              'title': element.title,
              'category': element.Category,
              'price': element.price,
              'size': element.Size,
              'quantity': element.quantity,
              'isFavorite': element.isfavorite,
            },
          ),
        )
            .then((response) {
          element.id = json.decode(response.body)['name'];
        });
      });
    } on Exception catch (e) {
      throw (e);
    }
  }

  Future<void> togglefavorites(Item item) async {
    String id = item.id;
    final oldStatus = item.isfavorite;
    item.isfavorite = !item.isfavorite;
    //
    final url = Uri.parse(
        'https://shop-clone-95314-default-rtdb.firebaseio.com/items/$id.json?auth=$authToken');
    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {'isFavorite': item.isfavorite},
        ),
      );
      if (response.statusCode >= 400) {
        item.isfavorite = oldStatus;
        notifyListeners();
      }
      notifyListeners();
    } on Exception catch (e) {
      print(e);
      item.isfavorite = oldStatus;
      notifyListeners();
    }
  }

  Future<void> RemoveItems() async {
    final Url = Uri.parse(
        'https://shop-clone-95314-default-rtdb.firebaseio.com/items.json');
    final response = await http.delete(Url);
  }

  Future<void> addItem(Item element) async {
    final Url = Uri.parse(
        'https://shop-clone-95314-default-rtdb.firebaseio.com/items.json?auth=$authToken');
    try {
      final response = await http
          .post(
        Url,
        body: json.encode(
          {
            'imageUrl': element.imageUrl,
            'title': element.title,
            'category': element.Category,
            'price': element.price,
            'size': element.Size,
            'quantity': element.quantity,
            'isFavorite': element.isfavorite,
          },
        ),
      )
          .then(
        (response) {
          element.id = json.decode(response.body)['name'];
          _items.add(element);
          notifyListeners();
        },
      );
    } on Exception catch (e) {
      throw (e);
    }
  }

  void updateSize(Item item, String size) {
    Item result = _items.lastWhere((element) => element.id == item.id);
    result.Size = size;
    notifyListeners();
  }
}
