import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/classes/order.dart';
import 'package:shop_clone/providers/orders.dart';
import 'package:shop_clone/widgets/appDrawer.dart';
import 'package:shop_clone/widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('My Orders'),
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<orders>(context).fetchdata(),
        builder: (ctx, datasnapshot) {
          if (datasnapshot.error != null) {
            print(datasnapshot.error.toString());
            return Center(
              child: Text('An error Occurred'),
            );
          } else {
            return OrderCard();
          }
        },
      ),
    );
  }
}
