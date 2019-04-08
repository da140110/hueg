import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../../scoped-models/main.dart';
import '../../models/contactDetail.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'departmentSelectionDialog.dart';
import '../../models/contactDepartment.dart';

class Contact extends StatefulWidget {
  final MainModel model;
  Contact(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ContactState();
  }
}

class _ContactState extends State<Contact> {
  TextEditingController controller = new TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  // Get json result and convert it to model. Then add

  List<ContactDetail> _searchResult = [];
  List<ContactDetail> _contactDetails = [];

  @override
  void initState() {
    if (widget.model.allContacts.length == 0) {
      widget.model.fetchContacts(widget.model.user.ownercode);
      //_contactDetails = widget.model.allContacts;
    }
    imageCache.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _bodyWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            openContactDeparment(widget.model);
          },
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ));
  }

  Widget _bodyWidget() {
    return Column(
      children: <Widget>[
        new Container(
          color: Theme.of(context).primaryColor,
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Card(
              child: new ListTile(
                leading: new Icon(Icons.search),
                title: new TextField(
                  controller: controller,
                  decoration: new InputDecoration(
                      hintText: 'Tìm kiếm', border: InputBorder.none),
                  onChanged: onSearchTextChanged,
                ),
                trailing: new IconButton(
                  icon: new Icon(Icons.cancel),
                  onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },
                ),
              ),
            ),
          ),
        ),

            ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
              Widget content = RefreshIndicator(
                  key:_refreshIndicatorKey,
                  onRefresh: _refresh,
                  child:new Center(
                child: Text('Không tìm thấy thông tin nào!'),
              ));
              if (widget.model.allContacts.length > 0 &&
                  !widget.model.isLoading) {
                _contactDetails = widget.model.allContacts;
                content = new Expanded(
                    child:
                        _searchResult.length != 0 || controller.text.isNotEmpty
                            ? _buildListViewContact(_searchResult)
                            : _buildListViewContact(_contactDetails));
              } else if (model.isLoading) {
                content = Center(child: CircularProgressIndicator());
              } else if (widget.model.allContacts.length == 0) {
                content = RefreshIndicator(
                    key:_refreshIndicatorKey,
                    onRefresh: _refresh,
                    child:new Center(
                  child: Text('Không tìm thấy thông tin nào!'),
                ));
              }
              return content;
            }),
      ],
    );
  }

  Future<Null> _refresh() {
    widget.model.fetchContacts(widget.model.user.ownercode);
      setState(() => _contactDetails = widget.model.allContacts);
    return null;
  }
  Widget _buildListViewContact(List<ContactDetail> listContactDetail) {
    Widget content;
    listContactDetail.length > 0
        ? content = new ListView.builder(
            itemCount: listContactDetail.length,
            itemBuilder: (context, i) {
              return _buildPhoneButton(listContactDetail[i]);
            },
          )
        : content = new Center(
            child: Text('Không tìm thấy thông tin nào!'),
          );
    return content;
  }

  Widget _buildPhoneButton(ContactDetail contact) {
    if (contact.dienthoai != '') {
      return (Card(
          child: new Column(children: <Widget>[
        new ListTile(
          onTap: () => openContactBox(contact, Colors.blue),
          leading: new CircleAvatar(
            backgroundImage: new NetworkImage(
              contact.anhcanhan,
            ),
          ),
          title: new Text(
            contact.hovaten,
            style: new TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
        new Divider(
          color: Colors.blue,
          indent: 16.0,
        ),
        new ListTile(
          onTap: () => _launchPhone(contact.dienthoai),
          leading: new Icon(
            Icons.phone,
            color: Colors.blue,
            size: 18.0,
          ),
          title: new Text(
            contact.dienthoai,
            style: new TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        )
      ])));
    } else
      return Card(
          child: new Column(
              children: (<Widget>[
        new ListTile(
          onTap: () => openContactBox(contact, Colors.blue),
          leading: new CircleAvatar(
            backgroundImage: new NetworkImage(
              contact.anhcanhan,
            ),
          ),
          title: new Text(
            contact.hovaten,
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
        ),
      ])));
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _contactDetails.forEach((ContactDetail) {
      if (ContactDetail.hovaten.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(ContactDetail);
    });
    setState(() {});
  }

  _launchPhone(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmail(String email) async {
    String url = 'mailto:' + email;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openContactBox(ContactDetail contact, Color myColor) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Thông tin nhân sự",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 0.0),
                      child: Column(
                        children: <Widget>[
                          new ListTile(
                            leading: new CircleAvatar(
                              backgroundImage: new NetworkImage(
                                  contact.anhcanhan,
                                  scale: 1.2),
                            ),
                            title: new Text(
                              contact.hovaten,
                              style: new TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ),
                          new ListTile(
                            leading: new Icon(
                              Icons.people,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                            title: new Text(
                              contact.chucvu != ''
                                  ? contact.chucvu
                                  : contact.bophan,
                              style: new TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          new ListTile(
                            onTap: () {
                              _launchEmail(
                                  contact.taikhoan + '@thuathienhue.gov.vn');
                            },
                            leading: new Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                            title: new Text(
                              contact.taikhoan + '@thuathienhue.gov.vn',
                              style: new TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          new ListTile(
                            leading: new Icon(
                              Icons.phone,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                            title: new Text(
                              contact.dienthoai,
                              style: new TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          new ListTile(
                            leading: new Icon(
                              Icons.home,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                            title: new Text(
                              contact.diachi,
                              style: new TextStyle(fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      )),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Đóng",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  openContactDeparment(model) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return DepartmentSelectionDialog(model);
        }).then((value) {
      if (value != null) {
        setState(() {
          widget.model.fetchContacts(value);
          //_contactDetails = widget.model.allContacts;
        });
      }
    });
  }
}
