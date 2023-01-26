import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_clone/classes/item.dart';
import 'package:shop_clone/providers/items.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({Key? key}) : super(key: key);

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _form = GlobalKey<FormState>();

  final _TitleNode = FocusNode();
  final _CategoryNode = FocusNode();
  final _ImageNode = FocusNode();
  final _PriceNode = FocusNode();

  String _title = '';
  String _imageUrl = '';
  String _Category = '';
  double _price = 0;

  Future<void> save() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    try {
      Item item = Item(
        id: '',
        title: _title,
        Category: _Category,
        imageUrl: _imageUrl,
        price: _price,
      );
      await Provider.of<Items>(context, listen: false).addItem(item);
      print('Item added');
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 6, bottom: 16, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 1,
              focusNode: _TitleNode,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Add Title';
                }
                if (value!.length <= 4) {
                  return 'Title should be atleast 5 Characters';
                }
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_CategoryNode);
              },
              onChanged: (value) {
                _title = value;
              },
              cursorColor: Colors.deepPurple.shade800,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade900,
                    width: 1.5,
                  ),
                ),
                label: const Text(
                  'Title',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            TextFormField(
              maxLines: 1,
              focusNode: _CategoryNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return 'Please Add Category';
                }
                if (value!.length < 2) {
                  return 'Category should be atleast 3 Characters';
                }
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_PriceNode);
              },
              onChanged: (value) {
                _Category = value;
              },
              cursorColor: Colors.deepPurple.shade800,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade900,
                    width: 1.5,
                  ),
                ),
                label: const Text(
                  'Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            TextFormField(
              maxLines: 1,
              focusNode: _PriceNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a price';
                }
                if (double.parse(value).isNegative) {
                  return 'Value must be greater than 0';
                }
                if (double.parse(value) >= 1500) {
                  return 'Value should be less than 1500';
                }
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_ImageNode);
              },
              onChanged: (value) {
                _price = double.parse(value);
              },
              cursorColor: Colors.deepPurple.shade800,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade900,
                    width: 1.1,
                  ),
                ),
                label: const Text(
                  'Price',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextFormField(
                    maxLines: 1,
                    focusNode: _ImageNode,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.toString().isEmpty)
                        return 'Please provide a ImageURL';
                      if (!value.toString().startsWith('http') &&
                          !value.toString().startsWith('https'))
                        return 'Please enter a valid URL';
                      if (!value.toString().endsWith('.png') &&
                          !value.toString().endsWith('.jpg') &&
                          !value.toString().endsWith('.jpeg'))
                        return 'Please Enter a Valid image Url';
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _imageUrl = value.toString();
                      });
                    },
                    cursorColor: Colors.deepPurple.shade800,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurple.shade900,
                          width: 1.5,
                        ),
                      ),
                      label: const Text(
                        'Image Url',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _imageUrl.isEmpty
                      ? const Center(
                          child: Text(
                            'Enter a URL',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : FittedBox(
                          child: Image.network(
                            _imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                    onPressed: save,
                    child: const Text('ADD ITEM'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
