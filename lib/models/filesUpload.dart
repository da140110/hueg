class FilesUpload {
  String fileName;
  String fileExtension;
  String fileContent;

  FilesUpload({this.fileName, this.fileExtension, this.fileContent});

  FilesUpload.fromJson(Map<String, dynamic> json) {
    fileName = json['file_name'];
    fileExtension = json['file_extension'];
    fileContent = json['file_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_name'] = this.fileName;
    data['file_extension'] = this.fileExtension;
    data['file_content'] = this.fileContent;
    return data;
  }
}