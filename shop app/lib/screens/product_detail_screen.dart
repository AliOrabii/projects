import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;

  // ProductDetailScreen(this.title);

  static const String routeName = '/Product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedproduct = Provider.of<Products>(
      context,
      listen: false,
    ).items.firstWhere(
          (prod) => prod.id == productId,
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedproduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: loadedproduct.id,
                child: Image.network(
                  loadedproduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedproduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedproduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
