import 'dart:convert';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/contactDetail.dart';
import '../common/constantURL.dart';

mixin ConnectedModel on Model {
  List<ContactDetail> _contactDetail = [];
  User _authenticatedUser;
  bool _isLoading = false;
}
mixin ContactDetailModel on ConnectedModel {
  List<ContactDetail> get allContacts {
    return List.from(_contactDetail);
  }

  Future<Null> fetchContacts() async {
    _isLoading = true;
    notifyListeners();

    return await http.get(GET_CONTACT_URL + _authenticatedUser.ownercode, headers: {
      'Content-Type': 'application/json',
      'username': 'ttthhc',
      'password': 'Abc@12345'
    }).then<Null>((http.Response response) {

      var allData = json.decode(response.body);
      var listofContacts = allData["danhsach_hoso"] as List;
      List<ContactDetail> fetchedContacts = listofContacts.map((i) => ContactDetail.fromJson(i)).toList();
      print(fetchedContacts.length);
      if (fetchedContacts == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      _contactDetail = fetchedContacts;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      print(error);
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
mixin UserModel on ConnectedModel {
  User get user {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(
      String username, String password) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password,
      "appCode": "Hue-G",
      "appOS": "IOS"
    };
    http.Response response;

    response = await http.post(
      LOGIN_URL,
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Lỗi xác thực tài khoản!';
    print(responseData);
    if (responseData.containsKey('Success') &&
        responseData['Success'] == true) {
      hasError = false;
      message = 'Đăng nhập thành công!';
      _authenticatedUser = User(
        username: username,
        password: password,
        token: responseData['Token'],
        success: true,
        address: responseData['Address'],
        fullname: responseData['FullName'],
        email: responseData['Email'],
        cellphone: responseData['CellPhone'],
        refreshtoken: responseData['RefreshToken'],
        ownercode: responseData['OwnerCode'],
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('username', username);
      prefs.setString('password', password);
      prefs.setString('token', responseData['Token']);
      prefs.setString('address', responseData['Address']);
      prefs.setString('fullname', responseData['FullName']);
      prefs.setString('email', responseData['Email']);
      prefs.setString('cellphone', responseData['CellPhone']);
      prefs.setString('refreshtoken', responseData['RefreshToken']);
      prefs.setString('ownercode', responseData['OwnerCode']);
    } else if (!responseData.containsKey('Success')) {
      message = 'Không kết nối được với server!';
    } else if (responseData.containsKey('Success') &&
        responseData['Success'] == false) {
      message = responseData['Message'];
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    if (token != null) {
      final String username = prefs.getString('username');
      final String token = prefs.getString('token');
      final String password = prefs.getString('password');
      final String address = prefs.getString('address');
      final String fullname = prefs.getString('fullname');
      final String email = prefs.getString('email');
      final String cellphone = prefs.getString('cellphone');
      final String refreshtoken = prefs.getString('refreshtoken');
      final String ownercode = prefs.getString('ownercode');

      _authenticatedUser = User(
          username: username,
          password: password,
          success: true,
          token: token,
          fullname: fullname,
          address: address,
          cellphone: cellphone,
          email: email,
          ownercode: ownercode,
          refreshtoken: refreshtoken);
      notifyListeners();
    }
  }

  void logout() async {
    print('Logout');
    _authenticatedUser = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('email');
    prefs.remove('address');
    prefs.remove('fullname');
    prefs.remove('cellphone');
    prefs.remove('refreshtoken');
    prefs.remove('ownercode');
  }
}
mixin UtilityModel on ConnectedModel {
  bool get isLoading {
    return _isLoading;
  }
}
