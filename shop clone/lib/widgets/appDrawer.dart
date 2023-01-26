import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/providers/auth.dart';
import 'package:shop_clone/screens/add_item.dart';
import 'package:shop_clone/screens/auth_screen.dart';
import 'package:shop_clone/screens/orders_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 20,
            ),
            height: 100,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            color: Color.fromARGB(255, 251, 250, 250),
            child: Text(
              'My Shop',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.shop,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Shop',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Theme.of(context).iconTheme.color,
            ),
            title: const Text(
              'My orders',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.edit,
              color: Theme.of(context).iconTheme.color,
            ),
            title: const Text(
              'Add Product',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AddItem.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.filter_list_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            title: const Text(
              'Filters',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              Provider.of<Auth>(context, listen: false).Logout();
              Navigator.of(context).pushReplacementNamed('/auth');
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).iconTheme.color,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              //Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
              Provider.of<Auth>(context, listen: false).Logout();
            },
          ),
        ],
      ),
    );
  }
}
