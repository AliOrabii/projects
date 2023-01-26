// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:country_phone_code_picker/country_phone_code_picker.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:shop_clone/classes/order.dart';
import 'package:shop_clone/providers/orders.dart';
import 'package:shop_clone/screens/confirmation_screen.dart';
import 'package:shop_clone/widgets/forms/user_info_form.dart';

class UserInfoScreen extends StatefulWidget {
  static const routeName = '/UserInfo';
  @override
  State<UserInfoScreen> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoScreen> {
  String countryValue = '';
  String stateValue = '';
  String cityValue = '';

  final _form = GlobalKey<FormState>();
  final _firstName = FocusNode();
  final _LastName = FocusNode();
  final _AddressInfo = FocusNode();
  @override
  Widget build(BuildContext context) {
    final Neworder = ModalRoute.of(context)!.settings.arguments as order;
    MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Address'),
        centerTitle: true,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'ADDRESS DETAILS',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple.shade800,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
              UserInfoForm(Neworder.user),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                  onPressed: () => Navigator.of(context).pushNamed(
                      ConfirmationScreen.routeName,
                      arguments: Neworder),
                  child: Text(
                    'SAVE',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
