import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../scoped-models/main.dart';
import 'tabNhatKyTraoDoi.dart';
import 'tabThongTinPhanAnh.dart';
import 'tabXuLyPhanAnh.dart';

class ChiTietPhanAnhPage extends StatefulWidget {
  final MainModel model;
  final String phananhid;
  ChiTietPhanAnhPage(this.model,this.phananhid);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ChiTietPhanAnhPageState();
  }
}
class ChiTietPhanAnhPageState extends State<ChiTietPhanAnhPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final tabController = new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          title: new Text("Chi tiết phản ánh"),
          bottom: new TabBar(
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(color: Colors.white,border: Border(top:BorderSide(width: 2.0,color: Colors.orange[300]))),
              labelColor: Colors.blue,
              indicatorColor: Colors.white,
              labelStyle:
              new TextStyle(fontSize: 15.0, color: Colors.deepOrange,fontWeight: FontWeight.bold),
              tabs: [
                new Tab( text: "CHI TIẾT"),
                new Tab( text: "XỬ LÝ"),
                new Tab( text: "NHẬT KÝ"),
              ]
          ),
        ),
        body: new TabBarView(children: [
          new TabThongTinPhanAnh(widget.model,widget.phananhid),
          new TabNhatKyTraoDoiPhanAnh(widget.model, widget.phananhid),
          new TabNhatKyTraoDoiPhanAnh(widget.model, widget.phananhid),
        ]),
      ),
    );
    return tabController;
  }
}
