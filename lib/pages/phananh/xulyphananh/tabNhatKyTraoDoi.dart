import 'package:flutter/material.dart';
import '../../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../models/nhatkyTraoDoiPhanAnh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TabNhatKyTraoDoiPhanAnh extends StatefulWidget {
  final MainModel model;
  final String phananhID;
  TabNhatKyTraoDoiPhanAnh(this.model, this.phananhID);
  @override
  _TabNhatKyTraoDoiPhanAnhState createState() =>
      new _TabNhatKyTraoDoiPhanAnhState();
}

class _TabNhatKyTraoDoiPhanAnhState extends State<TabNhatKyTraoDoiPhanAnh> {
  List<TraoDoiPhanAnh> _danhsachtraoDoiPhanAnh;
  @override
  void initState() {
    widget.model.fetchDanhSachTraoDoiPhanAnh(widget.phananhID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (widget.model.danhsachTraoDoiPhanAnh != null &&
            !widget.model.isLoading) {
          _danhsachtraoDoiPhanAnh = widget.model.danhsachTraoDoiPhanAnh;
          return _buildNhatKyTraoDoi(_danhsachtraoDoiPhanAnh);
        } else if (widget.model.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (widget.model.alldanhsachChoXuLy.length == 0)
          return Center(
            child: Text('Không có trao đổi nào!'),
          );
        return Center(
          child: Text('Không có trao  nào!'),
        );
      },
    );
  }

  Widget _buildNhatKyTraoDoi(
      List<TraoDoiPhanAnh> danhsachTraoDoiPhanAnh) {
    return new Padding(
        padding: EdgeInsets.all(5.0),
        child: new ListView.builder(itemBuilder: (context, index) {
          return new Column(children: <Widget>[
            new Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
              color: Colors.grey[300],
              child: new Text('Thời gian: '+
                danhsachTraoDoiPhanAnh[index].thoiGian,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.justify,
                style: new TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              padding:
              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
              color: Colors.grey[100],
              child: new Text(
                'Đơn vị trao đổi: ',
                //textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[500],
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 0.0, bottom: 5.0),
              color: Colors.grey[100],
              child: new Text(
                    (danhsachTraoDoiPhanAnh[index].donViTraoDoi != null
                        ? danhsachTraoDoiPhanAnh[index].donViTraoDoi.replaceAll('<br/>', ' - ')
                        : ' '),
                //textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 15.0,
                  //fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              padding:
              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
              color: Colors.grey[100],
              child: new Text(
                'Nội dung: ',
                //textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[500],
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
              color: Colors.grey[100],
              child: new Text(
                    (danhsachTraoDoiPhanAnh[index].noiDung != null
                        ? danhsachTraoDoiPhanAnh[index].noiDung.replaceAll('<br/>', ' - ')
                        : ' '),
                //textDirection: TextDirection.ltr,
                textAlign: TextAlign.justify,
                style: new TextStyle(
                  fontSize: 16.0,
                  //fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
              color: Colors.grey[100],
              child: new Text(
                'Thao tác: ',
                //textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[500],
                ),
              ),
            )
            ,
            new Container(
              width: MediaQuery.of(context).size.width,
              padding:
              EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
              color: Colors.grey[100],
              child: new Text(
                    (danhsachTraoDoiPhanAnh[index].thaoTac != null
                        ? danhsachTraoDoiPhanAnh[index].thaoTac
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

          Divider(
          height: 2.0,
          color: Colors.grey,
          )
          ]);
        },
          itemCount: danhsachTraoDoiPhanAnh.length,
        )
    );
  }


}
