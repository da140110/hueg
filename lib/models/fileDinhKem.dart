class FileDinhKem {
  String fileName;
  String fileNameThumb;

  FileDinhKem({this.fileName, this.fileNameThumb});

  FileDinhKem.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
    fileNameThumb = json['FileName_Thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileName'] = this.fileName;
    data['FileName_Thumb'] = this.fileNameThumb;
    return data;
  }
}