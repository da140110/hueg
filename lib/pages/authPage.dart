import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/background.dart';
import '../scoped-models/main.dart';


class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {'username': null, 'password': null};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildUsernameTextField() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 5, bottom: 5),
            child: TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nhập vào tên tài khoản',
                  hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 16)),
              style: TextStyle(fontSize: 18.0),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Nhập vào tên tài khoản';
                }
              },
              onSaved: (String value) {
                _formData['username'] = value;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: Material(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10))),
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 20, top: 5, bottom: 5),
            child: TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nhập vào mật khẩu',
                  hintStyle: TextStyle(color: Color(0xFFE1E1E1), fontSize: 16)),
              style: TextStyle(fontSize: 18.0),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Nhập vào mật khẩu';
                }
              },
              onSaved: (String value) {
                _formData['password'] = value;
              },
            ),
          ),
        ),
      ),
    );
  }

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
  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
      ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('images/background.jpg'),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
              //image: _buildBackgroundImage(),
            ),
            padding: EdgeInsets.all(0.0),
            child: Stack(
              children: <Widget>[
                Background(),
                Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3.0),
                        ),
                        Column(
                          children: <Widget>[
                            ///holds email header and inputField
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 40, bottom: 10),
                                  child: Text(
                                    "Tài khoản",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF999A9A)),
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: <Widget>[
                                    _buildUsernameTextField(),
                                    Padding(
                                        padding: EdgeInsets.only(right: 50),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Padding(
                                              padding: EdgeInsets.only(top: 40),
                                            )),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 40, bottom: 10),
                                  child: Text(
                                    "Mật khẩu",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF999A9A)),
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: <Widget>[
                                    _buildPasswordTextField(),
                                    Padding(
                                        padding: EdgeInsets.only(right: 50),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 40))),
                                          ],
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                            ),
                            ScopedModelDescendant<MainModel>(
                              builder: (BuildContext context, Widget child,
                                  MainModel model) {
                                return model.isLoading
                                    ? CircularProgressIndicator()
                                    : FlatButton(
                                        child: roundedRectButton("Đăng Nhập",
                                            signInGradients, false),
                                        onPressed: () =>
                                            _submitForm(model.authenticate));
                              },
                            ),
                          ],
                        )
                      ],
                    )),
              ],
            )));
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

  final List<Color> signInGradients = [
    Color(0xFF0EDED2),
    Color(0xFF03A0FE),
  ];

  final List<Color> signUpGradients = [
    Color(0xFFFF9945),
    Color(0xFFFc6076),
  ];
}
