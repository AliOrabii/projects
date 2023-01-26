import 'package:flutter/material.dart';

class ModalBottomSheet {
  static String? create(BuildContext context) {
    String? _size;
    showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (builder) => Container(
              height: 500,
              width: 300,
              child: Column(
                children: [
                  ListTile(
                    visualDensity: VisualDensity(vertical: -1),
                    enabled: false,
                    leading: Text(
                      'Select Size',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    visualDensity: VisualDensity(vertical: -3),
                    onTap: () {
                      _size = 'XS';
                      Navigator.pop(context);
                    },
                    leading: Text(
                      'XS',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    visualDensity: VisualDensity(vertical: -3),
                    onTap: () {
                      _size = 'Small';
                      Navigator.pop(context);
                    },
                    leading: Text(
                      'Small',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    visualDensity: VisualDensity(vertical: -3),
                    onTap: () {
                      _size = 'Meduim';
                      Navigator.pop(context);
                    },
                    leading: Text(
                      'Meduim',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    visualDensity: VisualDensity(vertical: -3),
                    onTap: () {
                      _size = 'Large';
                      Navigator.pop(context);
                    },
                    leading: Text(
                      'Large',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    visualDensity: VisualDensity(vertical: -3),
                    onTap: () {
                      _size = 'XL';
                      Navigator.pop(context);
                    },
                    leading: Text(
                      'XL',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    visualDensity: VisualDensity(vertical: -3),
                    onTap: () {
                      _size = 'XXL';
                      Navigator.pop(context);
                    },
                    leading: Text(
                      'XXL',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ));
    return _size;
  }
}
