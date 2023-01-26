import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_clone/providers/cart.dart';
import 'package:shop_clone/screens/cart_screen.dart';
import 'package:shop_clone/widgets/appDrawer.dart';
import 'package:shop_clone/widgets/filters.dart';
import '../providers/items.dart';
import '../widgets/shop_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ShopScreen extends StatefulWidget {
  @override
  State<ShopScreen> createState() => _ShopScreenState();
  static const routeName = '/Shop_Screen';
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Items>(context).fetchdata();
    super.didChangeDependencies();
  }

  var _selectedIndex = 0;
  var isfavorite = false;
  var filters = {
    'Categories': [],
    'from': 0,
    'To': 0,
  };
  var items = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (items[_selectedIndex].label == 'Home') {
        isfavorite = false;
      } else {
        isfavorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemsData = Provider.of<Items>(context);
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Myshop',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () =>
          //       showSearch(context: context, delegate: CustomSearchDelegate()),
          //   icon: Icon(Icons.search),
          // ),
          Stack(children: [
            Positioned(
              top: 6,
              left: 12,
              child: Text(
                '${cart.itemsCount}',
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
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        backgroundColor: Colors.white.withOpacity(0.6),
        currentIndex: _selectedIndex,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
        unselectedItemColor: Colors.grey,
        //showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.deepPurple.shade800,
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
        child: Wrap(
          runSpacing: -15,
          children: [
            Filters(),
            AnimationLimiter(
              child: GridView.builder(
                  dragStartBehavior: DragStartBehavior.start,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 270,
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: isfavorite
                      ? itemsData.Favs.length
                      : itemsData.items.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: isfavorite
                              ? ShopItem(itemsData.Favs[index])
                              : ShopItem(itemsData.items[index]),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
