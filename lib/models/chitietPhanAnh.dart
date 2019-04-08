import 'fileDinhKem.dart';
class ChiTietPhanAnh {
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
  List<FileDinhKem> danhSachFiledinhkem;
  String danhSachFiledinhkemKq;
  String donViThuLy;
  String trangthai;
  String danhgia;
  String ticketId;

  ChiTietPhanAnh(
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
        this.danhSachFiledinhkem,
        this.danhSachFiledinhkemKq,
        this.donViThuLy,
        this.trangthai,
        this.danhgia,
        this.ticketId});

  ChiTietPhanAnh.fromJson(Map<String, dynamic> json) {
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

    if (json['danh_sach_filedinhkem'] != null) {
      danhSachFiledinhkem = new List<FileDinhKem>();
      json['danh_sach_filedinhkem'].forEach((v) {
        danhSachFiledinhkem.add(new FileDinhKem.fromJson(v));
      });
    }
    danhSachFiledinhkemKq = json['danh_sach_filedinhkem_kq'];
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
    if (this.danhSachFiledinhkem != null) {
      data['danh_sach_filedinhkem'] =
          this.danhSachFiledinhkem.map((v) => v.toJson()).toList();
    }
    data['danh_sach_filedinhkem_kq'] = this.danhSachFiledinhkemKq;
    data['don_vi_thu_ly'] = this.donViThuLy;
    data['trangthai'] = this.trangthai;
    data['danhgia'] = this.danhgia;
    data['ticketId'] = this.ticketId;
    return data;
  }
}
