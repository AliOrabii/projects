import 'package:flutter/material.dart';

class AddressDetails extends StatelessWidget {
  final Neworder;
  bool canEdit = false;
  AddressDetails(this.Neworder, this.canEdit);

  Widget TextDisplay(String title, double size, FontWeight fontWeight) {
    return Text(
      title,
      style: TextStyle(fontSize: size, fontWeight: fontWeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        height: 130,
        width:
            canEdit ? double.infinity : MediaQuery.of(context).size.width * 0.7,
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextDisplay('${Neworder.user.Firstname} ${Neworder.user.Lastname}',
                20, FontWeight.w600),
            TextDisplay(Neworder.user.Country, 16, FontWeight.w400),
            SizedBox(height: 2),
            TextDisplay('${Neworder.user.City}, ${Neworder.user.State} ', 16,
                FontWeight.w400),
            SizedBox(height: 2),
            TextDisplay(Neworder.user.AddressInfo, 16, FontWeight.w400),
            SizedBox(height: 2),
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextDisplay(
                      Neworder.user.PhoneNumber, 16, FontWeight.w400),
                ),
                canEdit
                    ? Positioned(
                        right: 5,
                        top: -13,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Change Address',
                            style: TextStyle(color: Colors.deepPurple.shade800),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
