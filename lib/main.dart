import 'package:flutter/material.dart';
import 'package:hueg/pages/mainPage.dart';
import 'package:hueg/pages/authPage.dart';
//import 'package:hueg/pages/loginPage.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped-models/main.dart';
import './pages/phananh/xulyphananh/trangchuXuLyPhanAnh.dart';
import './pages/phananh/xulyphananh/chitietXuLyPhanAnh.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.autoAuthenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: "Đô Thị Thông Minh TT-Huế",
        //home : AuthPage()
        routes: {
          '/': (BuildContext context) => ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return model.user == null ? AuthPage() : MainPage(_model);
                },
              ),
          '/mainpage': (BuildContext context) => MainPage(_model),
          //'/xulyphananh': (BuildContext context) => ProductsAdminPage(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'xulyphananh') {
            String phananhid = '';
            try {
                phananhid=pathElements[2];
            }
            catch(e)
            {

            }

            if (phananhid=='')
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => TrangChuXuLyPhanAnh(model: _model),
            );
            else
              {
                //chitietXyLyPhanAnh
              }
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => MainPage(_model));
        },
      ),
    );
  }
}
