import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/drawer.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/Orders';

  @override
  Widget build(BuildContext context) {
    //final orderdata = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, dataSnapShot) {
              if (dataSnapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (dataSnapShot.error != null) {
                  print(dataSnapShot.error);
                  return Center(
                    child: Text('An error Occurred)'),
                  );
                } else {
                  return Consumer<Orders>(builder: (context, orderdata, child) {
                    return ListView.builder(
                      itemCount: orderdata.orders.length,
                      itemBuilder: (ctx, i) => orderdata.orders.isEmpty
                          ? Center(
                              child: Text('no orders add yet!'),
                            )
                          : OrderItem(orderdata.orders[i]),
                    );
                  });
                }
              }
            }));
  }
}
