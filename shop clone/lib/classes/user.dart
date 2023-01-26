import 'package:flutter/material.dart';

class UserInfo {
  String Firstname;
  String Lastname;
  String Username;
  String Password;
  String AddressInfo;
  String ExtraAddressInfo = '';
  String Country;
  String State;
  String City;
  String PhoneNumber;

  UserInfo(
    this.Firstname,
    this.Lastname,
    this.Username,
    this.Password,
    this.AddressInfo,
    this.Country,
    this.State,
    this.City,
    this.PhoneNumber,
  );
  Map<String, String> map() {
    return {
      'firstname': this.Firstname,
      'lastname': this.Lastname,
      'username': this.Username,
      'password': this.Password,
      'addressinfo': this.AddressInfo,
      'extraaddressinfo': this.ExtraAddressInfo,
      'country': this.Country,
      'state': this.State,
      'city': this.City,
      'phonenumber': this.PhoneNumber,
    };
  }
}
