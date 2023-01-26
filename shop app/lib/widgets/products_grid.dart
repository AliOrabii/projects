import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showfavs;

  ProductsGrid(this.showfavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showfavs ? productsData.Favitems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //create: (c) => products[i],
        value: products[i],
        child: ProductItem(
            //products[i].id,
            //products[i].title,
            //products[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
