import 'package:flutter/material.dart';
import '../../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../models/chitietPhanAnh.dart';
import '../../../models/fileDinhKem.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TabThongTinPhanAnh extends StatefulWidget {
  final MainModel model;
  final String phananhID;
  TabThongTinPhanAnh(this.model, this.phananhID);
  @override
  _TabThongTinPhanAnhState createState() => new _TabThongTinPhanAnhState();
}

class _TabThongTinPhanAnhState extends State<TabThongTinPhanAnh> {
  ChiTietPhanAnh _chiTietPhanAnh;
  @override
  void initState() {
    widget.model.fetchChiTietPhanAnh(widget.phananhID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (widget.model.chitietPhananh != null && !widget.model.isLoading) {
          _chiTietPhanAnh = widget.model.chitietPhananh;
          return _buildtableChiTietPhanAnh(_chiTietPhanAnh);
        } else if (widget.model.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (widget.model.alldanhsachChoXuLy.length == 0)
          return Center(
            child: Text('Không có phản ánh nào!'),
          );
        return Center(
          child: Text('Không có phản ánh nào!'),
        );
      },
    );
  }

  Widget _buildtableChiTietPhanAnh(ChiTietPhanAnh chitietphananh) {
    return new Padding(
        padding: EdgeInsets.all(5.0),
        child: new Container(
            child: new SingleChildScrollView(
                child: new ConstrainedBox(
                    constraints: new BoxConstraints(),
                    child: new Column(
                      //mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        _buildListOfImagePhanAnh(chitietphananh),
                        new Column(children: <Widget>[
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            color: Colors.grey[200],
                            child: new Text(
                              chitietphananh.tieude,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            color: Colors.grey[200],
                            child: new Text(
                              'Ngày phản ánh: ' +
                                  (chitietphananh.ngayphananh != null
                                      ? chitietphananh.ngayphananh
                                      : ' '),
                              //textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            color: Colors.grey[200],
                            child: new Text(
                              'Ngày hết hạn: ' +
                                  (chitietphananh.denngay != null
                                      ? chitietphananh.denngay
                                      : ' '),
                              //textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),

                          new Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            color: Colors.blueGrey[100],
                            child: new Text(
                              'Nội dung phản ánh: ',
                              //textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            color: Colors.blueGrey[100],
                            child: new Text(
                              chitietphananh.noidungPhananh,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            color: Colors.blueGrey[100],
                            child: new Text(
                              'Nội dung trả lời: ',
                              //textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                            color: Colors.blueGrey[100],
                            child: new Text(
                              chitietphananh.noidungTraloi,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ]),
                      ],
                    )))));
  }

  Widget _buildListOfImagePhanAnh(ChiTietPhanAnh chitietphananh) {
    Widget content = new SizedBox(
      height: 0,
      width: 0,
    );
    if (chitietphananh.danhSachFiledinhkem.length == 1) {
      content = Container(
        width: 600,
        height: 400,
        decoration: new BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          image: DecorationImage(
            image: new NetworkImage(
                chitietphananh.danhSachFiledinhkem[0].fileNameThumb),
            fit: BoxFit.fill,
          ),
          shape: BoxShape.rectangle,
        ),
      );
    } else if (chitietphananh.danhSachFiledinhkem.length > 1) {
      content = new SizedBox(
          height: 250.0,
          width: 700.0,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                alignment: const Alignment(1.0, -1.0),
                children: <Widget>[
                  new Container(
                    child:
                    new Image.network(
                        chitietphananh.danhSachFiledinhkem[index].fileNameThumb,
                        width: 700.0,
                        height: 250.0,
                        fit: BoxFit.cover),
                  ),
                  //How to set background to Text ?
                  //Let's move Text inside a Container,then set it's decoration
                  new Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: new BoxDecoration(color: new Color.fromARGB(150, 71, 150, 236)),
                    child: new Text(
                        '${index+1}' +
                            '/' +
                            '${chitietphananh.danhSachFiledinhkem.length}',
                        style: new TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ],
              );
            },
            itemCount: chitietphananh.danhSachFiledinhkem.length,
            viewportFraction: 0.8,
            scale: 0.8,
            itemWidth: 400.0,
            itemHeight: 600.0,
          ));
    }
    return content;
  }

  _buildRowChiTietPhanAnh(String title, String value) {
    return Expanded(
        child: new Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[Text(title), Text(value != null ? value : ' ')],
      ),
    ));
  }
}
