import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../utils/ensure_visible.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, dynamic> _formData = {'username': null, 'password': null};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation =
        await authenticate(_formData['username'], _formData['password']);
    print(successInformation);
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/mainpage');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Có lỗi xảy ra!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Thử lại'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[10],
      body: Form(
          key: _formKey,
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                constraints: BoxConstraints.expand(),
                //color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 10,
                      ),
                      Image.asset(
                        'images/logo_hueg.png',
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 6),
                        child: Text(
                          "ĐÔ THỊ THÔNG MINH",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 6),
                        child: Text(
                          "TỈNH THỪA THIÊN HUẾ",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Vui lòng đăng nhập để tiếp tục sử dụng!",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff606470)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: EnsureVisibleWhenFocused(
                            focusNode: _usernameFocusNode,
                            child: TextFormField(
                              autocorrect: false,
                              focusNode: _usernameFocusNode,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Nhập vào tên tài khoản';
                                }
                              },
                              onSaved: (String value) {
                                _formData['username'] = value;
                              },
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Tài khoản",
                                  prefixIcon: Container(
                                      width: 50, child: Icon(Icons.people)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffCED0D2), width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6)))),
                            )),
                      ),
                EnsureVisibleWhenFocused(
                  focusNode: _passwordFocusNode,
                  child:
                      TextFormField(
                        autocorrect: false,
                        focusNode: _passwordFocusNode,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Nhập vào mật khẩu';
                          }
                        },
                        onSaved: (String value) {
                          _formData['password'] = value;
                        },
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            labelText: "Mật khẩu",
                            prefixIcon: Container(
                                width: 50, child: Icon(Icons.vpn_key)),
                            suffixIcon: FlatButton(
                                onPressed: _toggle,
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 22,
                                )),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)))),
                      )),
                      Container(
                        constraints:
                            BoxConstraints.loose(Size(double.infinity, 40)),
                        alignment: AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                          child: Text(
                            "Quên mật khẩu?",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff606470)),
                          ),
                        ),
                      ),
                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child,
                            MainModel model) {
                          return model.isLoading
                              ? CircularProgressIndicator()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 40),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: RaisedButton(
                                      onPressed: () =>
                                          _submitForm(model.authenticate),
                                      child: Text(
                                        "Đăng nhập",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      color: Color(0xff3277D8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget roundedRectButton(
      String title, List<Color> gradient, bool isEndIconVisible) {
    return Builder(builder: (BuildContext mContext) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Stack(
          alignment: Alignment(1.0, 0.0),
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(mContext).size.width / 1.7,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Text(title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ),
            Visibility(
              visible: isEndIconVisible,
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ImageIcon(
                    AssetImage("assets/ic_forward.png"),
                    size: 30,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      );
    });
  }
}
