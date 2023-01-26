import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/classes/item.dart';
import 'package:shop_clone/providers/cart.dart';
import 'package:shop_clone/providers/items.dart';
import 'package:shop_clone/screens/cart_screen.dart';
import 'package:shop_clone/screens/shop_screen.dart';

class ItemDetailsScreen extends StatefulWidget {
  static const routeName = '/ItemDetailScreen';

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  String _dropdownvalue = 'Select Size';
  @override
  Widget build(BuildContext context) {
    final items = [
      DropdownMenuItem(
          child: Text('Select Size'), value: 'Select Size', enabled: false),
      DropdownMenuItem(child: Text('XS'), value: 'XS'),
      DropdownMenuItem(child: Text('Small'), value: 'Small'),
      DropdownMenuItem(child: Text('Meduim'), value: 'Meduim'),
      DropdownMenuItem(child: Text('Large'), value: 'Large'),
      DropdownMenuItem(child: Text('XL'), value: 'XL'),
      DropdownMenuItem(child: Text('XXL'), value: 'XXL'),
    ];

    final id = ModalRoute.of(context)?.settings.arguments as String;
    final Cartdata = Provider.of<Cart>(context, listen: false);
    final itemsdata = Provider.of<Items>(context, listen: false);
    final item = itemsdata.items.firstWhere(
      (element) => element.id == id,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, ShopScreen.routeName),
        ),
        foregroundColor: Colors.black,
        elevation: 1,
        shadowColor: Colors.white,
        centerTitle: true,
        actions: [
          Stack(children: [
            Positioned(
              top: 6,
              left: 12,
              child: Text(
                '${Cartdata.itemsCount}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: IconButton(
                onPressed: () => Navigator.pushReplacementNamed(
                    context, CartScreen.routeName),
                icon: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ]),
        ],
      ),
      body: Column(
        children: [
          Material(
            elevation: 5,
            child: Hero(
              tag: id,
              child: FadeInImage(
                height: 400,
                placeholder:
                    AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  item.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  item.Category,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "${item.price}  ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "EGP",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 140,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.0),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                          value: _dropdownvalue,
                          icon: const Icon(
                            Icons.expand_more,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _dropdownvalue = value!;
                              item.Size = _dropdownvalue;
                              itemsdata.updateSize(item, _dropdownvalue);
                            });
                          },
                          items: items,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 85,
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Added to Cart',
                              style: TextStyle(
                                  color: Color.fromRGBO(69, 39, 160, 1)),
                            ),
                            elevation: 2,
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.white,
                          ),
                        );
                        Cartdata.additem(item);
                      }),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
