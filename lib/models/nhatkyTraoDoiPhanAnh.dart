class TraoDoiPhanAnh {
  String nhatKyID;
  String thoiGian;
  String donViTraoDoi;
  String noiDung;
  String thaoTac;

  TraoDoiPhanAnh(
      {this.nhatKyID,
        this.thoiGian,
        this.donViTraoDoi,
        this.noiDung,
        this.thaoTac});

  TraoDoiPhanAnh.fromJson(Map<String, dynamic> json) {
    nhatKyID = json['NhatKyID'];
    thoiGian = json['ThoiGian'];
    donViTraoDoi = json['DonViTraoDoi'];
    noiDung = json['NoiDung'];
    thaoTac = json['ThaoTac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NhatKyID'] = this.nhatKyID;
    data['ThoiGian'] = this.thoiGian;
    data['DonViTraoDoi'] = this.donViTraoDoi;
    data['NoiDung'] = this.noiDung;
    data['ThaoTac'] = this.thaoTac;
    return data;
  }
}