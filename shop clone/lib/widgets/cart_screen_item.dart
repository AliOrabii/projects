import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/classes/item.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:shop_clone/providers/cart.dart';

class CartScreenItem extends StatefulWidget {
  final Item item;

  CartScreenItem(this.item);

  @override
  State<CartScreenItem> createState() => _CartScreenItemState();
}

class _CartScreenItemState extends State<CartScreenItem> {
  int simpleIntInput = 1;
  @override
  Widget build(BuildContext context) {
    final cartdata = Provider.of<Cart>(context, listen: false);
    return Container(
      height: 185,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage(
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                placeholder:
                    AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(widget.item.imageUrl),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.item.Category,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text('Size:  ${widget.item.Size}',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 4,
                  ),
                  Text('EGP ${widget.item.price}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(
                width: 10,
                height: 10,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                  onPressed: () => cartdata.removeitem(widget.item),
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 26,
                  ),
                  label: Text(
                    'Remove',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  )),
              Container(
                child: QuantityInput(
                    value: widget.item.quantity,
                    acceptsZero: false,
                    acceptsNegatives: false,
                    inputWidth: 60,
                    onChanged: (value) => setState(() {
                          if (int.parse(value) > simpleIntInput) {
                            cartdata.update_quantity(
                                widget.item.id, int.parse(value));
                          } else {
                            cartdata.update_quantity(
                                widget.item.id, int.parse(value));
                          }
                          simpleIntInput = int.parse(value.replaceAll(',', ''));
                        })),
              )
            ],
          ),
        ],
      ),
    );
  }
}
