import 'package:flutter/material.dart';

class ContactDepartment {
  final String tendonvi;
  final String madinhdanh;


  ContactDepartment(
      {@required this.tendonvi,
  @required this.madinhdanh});
  factory ContactDepartment.fromJson(Map<String, dynamic> json) {
    return new ContactDepartment(
        tendonvi: json['tendonvi'],
        madinhdanh: json['madinhdanh']
        );
  }
}