import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/modal_bottom_sheet.dart';
import '../providers/items.dart';
import '../providers/cart.dart';
import 'package:shop_clone/screens/item_details_screen.dart';
import '../classes/item.dart';

class ShopItem extends StatelessWidget {
  Item item;
  ShopItem(this.item);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final items = Provider.of<Items>(context, listen: false);
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ItemDetailsScreen.routeName,
                      arguments: item.id);
                },
                child: Hero(
                  tag: item.id,
                  child: FadeInImage(
                    height: 200,
                    placeholder:
                        AssetImage('assets/images/product-placeholder.png'),
                    image: NetworkImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () async {
                  await items.togglefavorites(item);
                  print(item.isfavorite);
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white,
                      duration: Duration(seconds: 1),
                      content: item.isfavorite
                          ? Text(
                              'Added to favorites',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )
                          : Text('Removed from Favorites',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                    ),
                  );
                },
                icon: Icon(
                  item.isfavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 90,
                width: double.infinity,
                color: Colors.white.withOpacity(0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' ${item.title}',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      ' ${item.Category}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          clipBehavior: Clip.hardEdge,
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, ItemDetailsScreen.routeName,
                              arguments: item.id),
                          child: Text(
                            'ADD TO CART',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Quicksand-Light',
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          child: Text(
                            'EGP ${item.price}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'Quicksand-Light',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
