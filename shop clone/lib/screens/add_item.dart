import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_clone/screens/shop_screen.dart';
import 'package:shop_clone/widgets/forms/add_item_form.dart';

class AddItem extends StatelessWidget {
  const AddItem({Key? key}) : super(key: key);

  static const routeName = '/addItem';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Add item'),
        foregroundColor: Colors.deepPurple.shade800,
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(ShopScreen.routeName),
          icon: Icon(Icons.adaptive.arrow_back),
        ),
      ),
      body: AddItemForm(),
    );
  }
}
