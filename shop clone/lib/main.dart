import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_clone/classes/item.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/items.dart';

import './screens/auth_screen.dart';
import './screens/cart_screen.dart';
import './screens/confirmation_screen.dart';
import './screens/item_details_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_info_screen.dart';
import './screens/shop_screen.dart';
import './screens/add_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ListenableProxyProvider<Auth, orders>(
          update: ((ctx, auth, previousorders) => orders(auth.token,
              previousorders == null ? [] : previousorders.OrderItems)),
        ),
        ListenableProxyProvider<Auth, Items>(
          update: ((ctx, auth, previousItems) => Items(
              auth.token, previousItems == null ? [] : previousItems.items)),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shop Clone',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.deepPurple.shade800),
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.deepPurple.shade800,
              ),
              fontFamily: 'QuickSand',
              primaryColor: Color.fromARGB(255, 81, 45, 168),
              pageTransitionsTheme: PageTransitionsTheme(
                  builders:
                      Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
                TargetPlatform.values,
                value: (dynamic _) => const FadeUpwardsPageTransitionsBuilder(),
              ))),
          home: auth.isAuth ? ShopScreen() : AuthScreen(),
          // : FutureBuilder(
          //     future: auth.tryAutologin(),
          //     builder: (context, snapshot) =>
          //         snapshot.connectionState == ConnectionState.waiting
          //             ? CircularProgressIndicator()
          //             : AuthScreen(),
          //   ),
          routes: {
            AuthScreen.routeName: (context) => AuthScreen(),
            ShopScreen.routeName: (context) => ShopScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            ItemDetailsScreen.routeName: (context) => ItemDetailsScreen(),
            UserInfoScreen.routeName: (context) => UserInfoScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            ConfirmationScreen.routeName: (context) => ConfirmationScreen(),
            AddItem.routeName: (context) => AddItem(),
          },
        ),
      ),
    );
  }
}
