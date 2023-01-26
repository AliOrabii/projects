import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import '../widgets/drawer.dart';
import '../widgets/user_product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/UserProductItem';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(
      context,
      listen: false,
    ).fetchData(true);
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding....');
    final productData = Provider.of<Products>(
      context,
      listen: false,
    );
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productData.items.length,
                          itemBuilder: ((_, i) => Column(
                                children: [
                                  UserProductItem(
                                    productData.items[i].id,
                                    productData.items[i].title,
                                    productData.items[i].imageUrl,
                                  ),
                                  Divider(),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
