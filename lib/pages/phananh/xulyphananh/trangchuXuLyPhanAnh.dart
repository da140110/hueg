import 'package:flutter/material.dart';
import 'package:hueg/models/danhsachChoXuLyPhanAnh.dart' as prefix0;
import '../../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../models/danhsachChoXuLyPhanAnh.dart';
import '../../../models/fileDinhKem.dart';
import 'chitietXuLyPhanAnh.dart';

class TrangChuXuLyPhanAnh extends StatefulWidget {
  final MainModel model;
  TrangChuXuLyPhanAnh({this.model});
  @override
  _TrangChuXuLyPhanAnhState createState() => new _TrangChuXuLyPhanAnhState();
}

class _TrangChuXuLyPhanAnhState extends State<TrangChuXuLyPhanAnh> {
  List<DanhSachChoXuLyPhanAnh> _danhSachChoXuLyPhanAnh = [];
  @override
  void initState() {
    if (_danhSachChoXuLyPhanAnh.length == 0) {
      widget.model.fetchDanhSachChoXuLy();
    }
    print(_danhSachChoXuLyPhanAnh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text(
                "Xử lý phản ánh",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              backgroundColor: Colors.blueAccent,
//              actions: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(right: 24.0),
//                  child: Icon(
//                    Icons.notifications_none,
//                    color: Colors.white,
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(right: 12.0),
//                  child: Icon(Icons.search, color: Colors.white),
//                ),
//              ],
            ),
            body: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                if (widget.model.alldanhsachChoXuLy.length > 0 &&
                    !widget.model.isLoading) {
                  _danhSachChoXuLyPhanAnh = widget.model.alldanhsachChoXuLy;
                  print(_danhSachChoXuLyPhanAnh.length);
                  return _widgetListViewDanhSachPhanAnh(
                      _danhSachChoXuLyPhanAnh);
                } else if (widget.model.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (widget.model.alldanhsachChoXuLy.length == 0)
                  return Center(
                    child: Text('Không có phản ánh nào đang chờ xử lý!'),
                  );
                return Center(
                  child: Text('Không có phản ánh nào đang chờ xử lý!'),
                );
              },
            )));
  }

  _widgetListViewDanhSachPhanAnh(List<DanhSachChoXuLyPhanAnh> xulyPhanAnh) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: xulyPhanAnh.length == 0
            ? Center(
                child: Text('Không có phản ánh nào đang chờ xử lý!'),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  DanhSachChoXuLyPhanAnh xulyPhanAnh =
                      _danhSachChoXuLyPhanAnh[index];
                  String noidungphananh = xulyPhanAnh.noidungPhananh;
                  String tieude = xulyPhanAnh.tieude;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
                    child: new GestureDetector(
                        //You need to make my child interactive
                        onTap: () => _openChiTietPhanAnh(widget.model,xulyPhanAnh.id)
                        ,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(xulyPhanAnh.tieude,
                                        style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0),
                                      ),
                                      flex: 5,
                                    ),

                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 12.0, 0.0, 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          noidungphananh.substring(
                                                  0,
                                                  noidungphananh.length > 100
                                                      ? 100
                                                      : noidungphananh.length) +
                                              '...',
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        flex: 3,
                                      ),
                                      xulyPhanAnh.danhSachFiledinhkem.length>0?
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                            height: 90.0,
                                            width: 90.0,
                                            child: Image.network(
                                              xulyPhanAnh.danhSachFiledinhkem
                                                          .length >
                                                      0
                                                  ? xulyPhanAnh
                                                      .danhSachFiledinhkem[0]
                                                      .fileNameThumb
                                                  : '',
                                              fit: BoxFit.cover,
                                            )),
                                      ):
                                          SizedBox(
                                            width: 0,
                                            height: 0,
                                          )
                                      ,
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                              xulyPhanAnh.ngayphananh,
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Text('Ngày hết hạn: ' + (xulyPhanAnh.denngay!=null?xulyPhanAnh.denngay:' '),
                                      style: TextStyle(
                                          color: Colors.red[400],
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  );
                },
                itemCount: _danhSachChoXuLyPhanAnh.length,
              ));
  }
  _openChiTietPhanAnh(MainModel model,String phananhid) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ChiTietPhanAnhPage(model,phananhid);
        });

  }
  void showMenuSelection(String value) {
    print('You selected: $value');
  }
}
