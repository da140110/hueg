class DanhSachThongBao {
  String id;
  String tieude;
  String nguoithongbao;
  String ngaythongbao;
  String daxem;
  int mucdo;

  DanhSachThongBao(
      {this.id,
        this.tieude,

        this.nguoithongbao,

        this.ngaythongbao,
        this.daxem,
        this.mucdo});

  DanhSachThongBao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tieude = json['tieude'];
    nguoithongbao = json['nguoithongbao'];
    ngaythongbao = json['ngaythongbao'];
    daxem = json['daxem'];
    mucdo = json['mucdo'];
  }

}