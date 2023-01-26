import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../helpers/custom_route.dart';
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 20,
            ),
            height: 120,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'My Shop',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              'Shop',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text(
                'My orders',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () =>
                  // Navigator.of(context)
                  //     .pushReplacementNamed(OrdersScreen.routeName),
                  Navigator.of(context).pushReplacement(
                    CustomRoute(
                      builder: (ctx) => OrdersScreen(),
                    ),
                  )),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Manage Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).Logout();
            },
          ),
        ],
      ),
    );
  }
}
