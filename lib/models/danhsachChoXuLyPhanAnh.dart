import 'package:json_annotation/json_annotation.dart';
import 'fileDinhKem.dart';
@JsonSerializable(nullable: true)
class DanhSachChoXuLyPhanAnh {
  String id;
  String nguonid;
  String linhvucid;
  String tenlinhvuc;
  String taikhoan;
  String nguoiphananh;
  String dienthoai;
  String diachi;
  String email;
  String tieude;
  String noidungPhananh;
  String filephananh;
  String ngayphananh;
  String kinhdo;
  String vido;
  String noidungTraloi;
  String filetraloi;
  String ngaytraloi;
  String diachiSukien;
  bool congKhai;
  String upload;
  String noiDungPhanPhoi;
  String tungay;
  String denngay;
  String danhSachBinhluan;
  List<FileDinhKem> danhSachFiledinhkem;
  String donViThuLy;
  String trangthai;
  String danhgia;
  String ticketId;

  DanhSachChoXuLyPhanAnh(
      {this.id,
        this.nguonid,
        this.linhvucid,
        this.tenlinhvuc,
        this.taikhoan,
        this.nguoiphananh,
        this.dienthoai,
        this.diachi,
        this.email,
        this.tieude,
        this.noidungPhananh,
        this.filephananh,
        this.ngayphananh,
        this.kinhdo,
        this.vido,
        this.noidungTraloi,
        this.filetraloi,
        this.ngaytraloi,
        this.diachiSukien,
        this.congKhai,
        this.upload,
        this.noiDungPhanPhoi,
        this.tungay,
        this.denngay,
        this.danhSachBinhluan,
        this.danhSachFiledinhkem,
        this.donViThuLy,
        this.trangthai,
        this.danhgia,
        this.ticketId});

  DanhSachChoXuLyPhanAnh.fromJson(Map<String, dynamic> json) {
    var listFileDinhKem =json['danh_sach_filedinhkem'] as List;
    List<FileDinhKem> fetchedFileDinhKem = listFileDinhKem
        .map((i) => FileDinhKem.fromJson(i))
        .toList();
    id = json['id'];
    nguonid = json['nguonid'];
    linhvucid = json['linhvucid'];
    tenlinhvuc = json['tenlinhvuc'];
    taikhoan = json['taikhoan'];
    nguoiphananh = json['nguoiphananh'];
    dienthoai = json['dienthoai'];
    diachi = json['diachi'];
    email = json['email'];
    tieude = json['tieude'];
    noidungPhananh = json['noidung_phananh'];
    filephananh = json['filephananh'];
    ngayphananh = json['ngayphananh'];
    kinhdo = json['kinhdo'];
    vido = json['vido'];
    noidungTraloi = json['noidung_traloi'];
    filetraloi = json['filetraloi'];
    ngaytraloi = json['ngaytraloi'];
    diachiSukien = json['diachi_sukien'];
    congKhai = json['cong_khai'];
    upload = json['upload'];
    noiDungPhanPhoi = json['noi_dung_phan_phoi'];
    tungay = json['tungay'];
    denngay = json['denngay'];
    danhSachBinhluan = json['danh_sach_binhluan'];
    danhSachFiledinhkem = fetchedFileDinhKem;
    donViThuLy = json['don_vi_thu_ly'];
    trangthai = json['trangthai'];
    danhgia = json['danhgia'];
    ticketId = json['ticketId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nguonid'] = this.nguonid;
    data['linhvucid'] = this.linhvucid;
    data['tenlinhvuc'] = this.tenlinhvuc;
    data['taikhoan'] = this.taikhoan;
    data['nguoiphananh'] = this.nguoiphananh;
    data['dienthoai'] = this.dienthoai;
    data['diachi'] = this.diachi;
    data['email'] = this.email;
    data['tieude'] = this.tieude;
    data['noidung_phananh'] = this.noidungPhananh;
    data['filephananh'] = this.filephananh;
    data['ngayphananh'] = this.ngayphananh;
    data['kinhdo'] = this.kinhdo;
    data['vido'] = this.vido;
    data['noidung_traloi'] = this.noidungTraloi;
    data['filetraloi'] = this.filetraloi;
    data['ngaytraloi'] = this.ngaytraloi;
    data['diachi_sukien'] = this.diachiSukien;
    data['cong_khai'] = this.congKhai;
    data['upload'] = this.upload;
    data['noi_dung_phan_phoi'] = this.noiDungPhanPhoi;
    data['tungay'] = this.tungay;
    data['denngay'] = this.denngay;
    data['danh_sach_binhluan'] = this.danhSachBinhluan;
    data['danh_sach_filedinhkem'] = this.danhSachFiledinhkem;
    data['don_vi_thu_ly'] = this.donViThuLy;
    data['trangthai'] = this.trangthai;
    data['danhgia'] = this.danhgia;
    data['ticketId'] = this.ticketId;
    return data;
  }
}