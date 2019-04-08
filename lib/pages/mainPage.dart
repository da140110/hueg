import 'package:flutter/material.dart';
import './authPage.dart';
import 'package:hueg/pages/about.dart';
import 'package:hueg/pages/contact/contact.dart';
import 'package:hueg/pages/homePage.dart';
import 'package:hueg/pages/notification.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import '../scoped-models/main.dart';

class MainPage extends StatefulWidget {
  final MainModel model;
  MainPage(this.model);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  var title = ''; //title is "mutable property"
  Drawer _buildDrawer(context) {
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeader(
            child: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'images/profile.png',
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                  new Text(widget.model.user.fullname,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                    ),
                  ),
                  new Text(widget.model.user.email,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new AssetImage("images/bg_drawer.png"))),
          ),
          new ListTile(
            leading: new Icon(Icons.book),
            title: new Text('Danh bạ đơn vị'),
            onTap: () {
              Navigator.pop(context);

            },
          ),
          new ListTile(
            leading: new Icon(Icons.notifications),
            title: new Text('Thông báo'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.settings),
            title: new Text('Tin nội bộ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new Divider(
            color: Colors.black45,
            indent: 16.0,
          ),
          new ListTile(
            title: new Text('Giới thiệu'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.exit_to_app),
            title: new Text('Đăng xuất '),
            onTap: () {
              widget.model.logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final tabController = new DefaultTabController(
      length: 4,
      child: new Scaffold(
        bottomNavigationBar: new Material(
          color: Colors.indigo,
          child: new TabBar(
              labelStyle:
                  new TextStyle(fontSize: 12.0, color: Colors.deepOrange),
              tabs: [
                new Tab(icon: new Icon(Icons.home), text: "Trang chủ"),
                new Tab(icon: new Icon(Icons.notifications), text: "Thông báo"),
                new Tab(icon: new Icon(Icons.phone), text: "Liên hệ"),
                new Tab(icon: new Icon(Icons.contacts), text: "Banh bạ")
              ]
          ),
        ),
        appBar: new AppBar(
          backgroundColor: Colors.blueAccent,
          title: new Text("Đô Thị Thông Minh TT-Huế"),
        ),
        body: new TabBarView(children: [
          new HomePage(),
          new DanhSachThongBaoPage(widget.model),
          new About(),
          new Contact(widget.model),
        ]),
        drawer: _buildDrawer(context),
      ),
    );
    return tabController;
  }
}
