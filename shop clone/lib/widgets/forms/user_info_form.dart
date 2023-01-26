import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:shop_clone/classes/user.dart';

class UserInfoForm extends StatefulWidget {
  UserInfo user;
  UserInfoForm(this.user);
  @override
  State<UserInfoForm> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<UserInfoForm> {
  String _firstName = '';
  String _LastName = '';
  String _AddressInfo = '';
  String _ExtraAddressInfo = '';
  String _PhoneNumber = '';

  String countryValue = '';
  String stateValue = '';
  String cityValue = '';

  final _form = GlobalKey<FormState>();
  final _firstNameNode = FocusNode();
  final _LastNameNode = FocusNode();
  final _AddressInfoNode = FocusNode();
  final _ExtraAddressInfoNode = FocusNode();
  final _PhoneNumberNode = FocusNode();

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: 530,
      child: Form(
        key: _form,
        child: ListView(
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return 'Please Enter a Name';
                return null;
              },
              onChanged: (value) {
                _firstName = value;
                widget.user.Firstname = _firstName;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_LastNameNode);
              },
              focusNode: _firstNameNode,
              textInputAction: TextInputAction.next,
              cursorColor: Color.fromARGB(255, 81, 45, 168),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.deepPurple.shade900,
                  width: 1.5,
                )),
                label: const Text(
                  'First Name',
                  style: TextStyle(
                      color: Color.fromARGB(255, 81, 45, 168),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return 'Please Enter a Name';
                return null;
              },
              onChanged: (value) {
                _LastName = value;
                widget.user.Lastname = _LastName;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_AddressInfoNode);
              },
              focusNode: _LastNameNode,
              cursorColor: const Color.fromARGB(255, 81, 45, 168),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple.shade900,
                      width: 1.5,
                    ),
                  ),
                  label: const Text(
                    'Last Name',
                    style: TextStyle(
                        color: Color.fromARGB(255, 81, 45, 168),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return 'Please Add your address';
                return null;
              },
              onChanged: ((newValue) {
                _AddressInfo = newValue;
                widget.user.AddressInfo = _AddressInfo;
              }),
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_ExtraAddressInfoNode);
              },
              focusNode: _AddressInfoNode,
              cursorColor: Colors.deepPurple.shade800,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade900,
                    width: 1.5,
                  ),
                ),
                label: const Text(
                  'Building number/St.name/Apartment number',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 81, 45, 168),
                      fontWeight: FontWeight.w600),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            TextFormField(
              onChanged: ((newValue) {
                _ExtraAddressInfo = newValue;
                widget.user.ExtraAddressInfo = _ExtraAddressInfo;
              }),
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_PhoneNumberNode);
              },
              focusNode: _ExtraAddressInfoNode,
              cursorColor: Colors.deepPurple.shade800,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple.shade900,
                    width: 1.5,
                  ),
                ),
                label: const Text(
                  'Additional Address info',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 81, 45, 168),
                      fontWeight: FontWeight.w600),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SelectState(
              style: const TextStyle(
                  color: Color.fromARGB(255, 81, 45, 168),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'QuickSand'),
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                  widget.user.Country = countryValue;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value;
                  widget.user.State = stateValue;
                });
              },
              onCityChanged: (value) {
                cityValue = value;
                widget.user.City = cityValue;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return 'Please Enter a Phone Number';
                if (!value.startsWith('+')) return 'Please add a Country Code';
                return null;
              },
              onChanged: ((newValue) {
                _PhoneNumber = newValue;
                widget.user.PhoneNumber = _PhoneNumber;
              }),
              onEditingComplete: () {
                setState(() {});
                _saveForm();
              },
              keyboardType: TextInputType.number,
              focusNode: _PhoneNumberNode,
              decoration: InputDecoration(
                label: Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.deepPurple.shade800,
                      fontWeight: FontWeight.w600),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
