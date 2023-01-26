import 'package:flutter/src/foundation/key.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/classes/order.dart';
import '../widgets/dialog/custom_dialog.dart';
import '../providers/orders.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  Widget TextDisplay(String title, double size, FontWeight fontWeight) {
    return Text(
      title,
      style: TextStyle(fontSize: size, fontWeight: fontWeight),
    );
  }

  Widget title(String name) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2),
        ),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget Space(double x) {
    return SizedBox(
      height: x,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<orders>(
      builder: (context, orderdata, child) {
        return ListView.builder(
          itemCount: orderdata.OrderItems.length,
          itemBuilder: (ctx, i) => orderdata.OrderItems.isEmpty
              ? const Center(
                  child: Text('no orders add yet'),
                )
              : Card(
                  elevation: 8,
                  child: ExpansionTile(
                    textColor: Color.fromRGBO(69, 39, 160, 1),
                    iconColor: Color.fromRGBO(69, 39, 160, 1),
                    title: TextDisplay(orderdata.OrderItems[i].DateCreated, 18,
                        FontWeight.w600),
                    children: [
                      Container(
                        foregroundDecoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 0.6,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        height: 150,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextDisplay(
                                    orderdata.OrderItems[i].user.Firstname,
                                    16,
                                    FontWeight.w600),
                                const SizedBox(
                                  width: 4,
                                ),
                                TextDisplay(
                                    orderdata.OrderItems[i].user.Lastname,
                                    16,
                                    FontWeight.w600),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${orderdata.OrderItems[i].user.Country} ,',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  ' ${orderdata.OrderItems[i].user.City}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              orderdata.OrderItems[i].user.AddressInfo,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                title('Order Status'),
                                const Text(
                                  ' :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  ' ${orderdata.OrderItems[i].status.name}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(69, 39, 160, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                title('Total'),
                                const Text(
                                  ' :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  ' ${orderdata.OrderItems[i].total.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Color.fromRGBO(69, 39, 160, 1)),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    title('Number of items'),
                                    const Text(
                                      ' :',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      ' ${orderdata.OrderItems[i].CartItems.length}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(69, 39, 160, 1),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 10,
                                  child: TextButton(
                                    child: const Text(
                                      'Order Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(69, 39, 160, 1)),
                                    ),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (ctx) =>
                                          CustomDialog(orderdata.OrderItems[i]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
