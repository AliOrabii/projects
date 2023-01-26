import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import 'package:http/http.dart' as http;
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authdata = Provider.of<Auth>(context, listen: false);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                placeholder:
                    AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: Icon(product.isfavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavoriteStatus(
                  authdata.token,
                  authdata.userId,
                );
              },
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item added to cart !'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
