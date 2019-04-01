import 'package:flutter/material.dart';

class User {
  final String username;
  final String password;
  final bool success;
  final String token;
  final String refreshtoken;
  final String fullname;
  final String address;
  final String cellphone;
  final String email;
  final String ownercode;
  User({@required this.username,@required this.password,@required this.success, this.token,this.refreshtoken,this.fullname,this.address,
      this.cellphone,this.email,this.ownercode});


}