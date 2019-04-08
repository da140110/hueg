import 'filesUpload.dart';
class XyLyPhanAnh {
  String id;
  String noidungTraloi;
  List<FilesUpload> upload;

  XyLyPhanAnh({this.id, this.noidungTraloi, this.upload});

  XyLyPhanAnh.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noidungTraloi = json['noidung_traloi'];
    if (json['upload'] != null) {
      upload = new List<FilesUpload>();
      json['upload'].forEach((v) {
        upload.add(new FilesUpload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['noidung_traloi'] = this.noidungTraloi;
    if (this.upload != null) {
      data['upload'] = this.upload.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

