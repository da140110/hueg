import 'package:flutter/material.dart';
class About extends StatelessWidget{
  @override

  Widget build(BuildContext context)
  {
    var card = new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.account_box, color: Colors.blue,size: 27.0,),
            title: new Text("Trung Tâm Giám Sát Điều Hành Đô Thị Thông Minh - Tỉnh Thừa Thiên Huế"
              ,style: new TextStyle(fontWeight: FontWeight.w700),),
            subtitle: new Text("36 - Phạm Văn Đồng - Tp Huế - TT Huế"),
          ),

          new Divider(color: Colors.blue,indent: 16.0,),
          new ListTile(
            leading: new Icon(Icons.web, color: Colors.blue, size: 26.0,),
            title: new Text("https://tuongtac.thuathienhue.gov.vn"
              ,style: new TextStyle(fontWeight: FontWeight.w400),),
          ),

          new ListTile(
            leading: new Icon(Icons.email, color: Colors.blue, size: 26.0,),
            title: new Text("dttm@thuathienhue.gov.vn"
              ,style: new TextStyle(fontWeight: FontWeight.w400),),
          ),
          new ListTile(
            leading: new Icon(Icons.phone, color: Colors.blue, size: 26.0,),
            title: new Text("+84-941260505"
              ,style: new TextStyle(fontWeight: FontWeight.w400),),
          )
        ],
      ),
    );
    final sizedBox = new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        height: 500.0,
        child: card,
      ),
    );
    final center = new Center(
      child: sizedBox,
    );
    return new Center(
      child: sizedBox,
    );
  }
}