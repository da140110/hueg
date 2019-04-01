import 'package:flutter/material.dart';

class ContactDetail {
  final String hovaten;
  final String gioitinh;
  final String ngaysinh;
  final String diachi;
  final String chucvu;
  final String bophan;
  final String taikhoan;
  final String cmnd;
  final String macongchuc;
  final String madinhdanh;
  final String anhcanhan;
  final String tendonvi;
  final String dienthoai;
  final String trinhdochuyenmon;
  final String hosoid;

  ContactDetail(
      {@required this.hovaten,
      this.gioitinh,
      this.ngaysinh,
      this.diachi,
      this.chucvu,
      this.bophan,
      this.taikhoan,
      this.cmnd,
      this.macongchuc,
      this.madinhdanh,
      this.anhcanhan,
      this.tendonvi,
      this.dienthoai,
      this.trinhdochuyenmon,
      this.hosoid});
  factory ContactDetail.fromJson(Map<String, dynamic> json) {
    return new ContactDetail(
        hosoid: json['hosoid'],
        hovaten: json['hovaten'],
        gioitinh: json['gioitinh'],
        ngaysinh: json['ngaysinh'],
        diachi: json['diachi'],
        chucvu: json['chucvu'],
        bophan: json['bophan'],
        taikhoan: json['taikhoan'],
        cmnd: json['cmnd'],
        macongchuc: json['macongchuc'],
        madinhdanh: json['madinhdanh'],
        anhcanhan: json['anhcanhan'],
        tendonvi: json['tendonvi'],
        dienthoai: json['dienthoai'],
        trinhdochuyenmon: json['trinhdochuyenmon']);
  }
}
