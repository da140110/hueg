import 'package:flutter/material.dart';
import '../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/danhsachThongBao.dart';


class DanhSachThongBaoPage extends StatefulWidget {
  final MainModel model;
  DanhSachThongBaoPage(this.model);
  @override
  _DanhSachThongBaoPageState createState() =>
      new _DanhSachThongBaoPageState();
}

class _DanhSachThongBaoPageState extends State<DanhSachThongBaoPage> {
  List<DanhSachThongBao> _danhsachThongBao;
  @override
  void initState() {
    widget.model.fetchDanhSachThongBao();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: Text('Thông báo ',
        style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 23.0)),
    ),
    body: ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (widget.model.danhsachTraoDoiPhanAnh != null &&
            !widget.model.isLoading) {
          _danhsachThongBao = widget.model.danhsachThonBao;
          return _buildDanhSachThongBao(_danhsachThongBao);
        } else if (widget.model.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (widget.model.danhsachThonBao.length == 0)
          return Center(
            child: Text('Không có thông báo nào!'),
          );
        return Center(
          child: Text('Không có thông báo  nào!'),
        );
      },
    ));
  }

  Widget _buildDanhSachThongBao(
      List<DanhSachThongBao> danhsachThongBao) {
    return new Padding(
        padding: EdgeInsets.all(5.0),
        child: new ListView.builder(
          itemBuilder: (context, index) {
            String ngaythongbao=danhsachThongBao[index].ngaythongbao;
            ngaythongbao=ngaythongbao.substring(0,ngaythongbao.indexOf(' '));
            return
              Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                          child: Text(
            danhsachThongBao[index].tieude,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ngaythongbao,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.notifications,
                              size: 20.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                )
              ],
            );
          },
          itemCount: danhsachThongBao.length,
        ),
    );
  }


}
