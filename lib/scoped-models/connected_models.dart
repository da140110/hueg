import 'dart:convert';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/contactDetail.dart';
import '../common/constantURL.dart';
import '../models/contactDepartment.dart';
import '../models/danhsachChoXuLyPhanAnh.dart';
import '../models/chitietPhanAnh.dart';
import '../models/nhatkyTraoDoiPhanAnh.dart';
import '../models/danhsachThongBao.dart';

mixin ConnectedModel on Model {
  List<DanhSachThongBao> _danhsachThongBao=[];
  List<ContactDetail> _contactDetail = [];
  List<ContactDepartment> _contactDepartment = [];
  List<DanhSachChoXuLyPhanAnh> _danhsachChoXuLyPhanAnh = [];
  List<TraoDoiPhanAnh> _danhsachTraoDoiPhanAnh = [];
  ChiTietPhanAnh _chitietPhanAnh;
  String token = '';
  User _authenticatedUser;
  bool _isLoading = false;
}
mixin ThongBaoModel on ConnectedModel {
  List<DanhSachThongBao> get danhsachThonBao{
    return List.from(_danhsachThongBao);
  }

  Future<Null> fetchDanhSachThongBao() async {
    _isLoading = true;
    notifyListeners();
    return await http.get(GET_DANHSACH_THONGBAO_URL,
        headers: {'token': token}).then<Null>((http.Response response) {
      var allData = json.decode(response.body);

      var listDanhSachThongBao = allData["danh_sach_thongBao"] as List;

      List<DanhSachThongBao> fetchedDanhSachThongBao =
      listDanhSachThongBao.map((i) => DanhSachThongBao.fromJson(i)).toList();

      if (fetchedDanhSachThongBao == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      _danhsachThongBao = fetchedDanhSachThongBao;
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
mixin DanhSachTraoDoiModel on ConnectedModel {
  List<TraoDoiPhanAnh> get danhsachTraoDoiPhanAnh {
    return List.from(_danhsachTraoDoiPhanAnh);
  }

  Future<Null> fetchDanhSachTraoDoiPhanAnh(String phananhid) async {
    _isLoading = true;
    notifyListeners();
    return await http.get(GET_DANHSACH_TRAODOI_PHANANH_URL + phananhid,
        headers: {'token': token}).then<Null>((http.Response response) {
      var allData = json.decode(response.body);

      var listDanhSachTraoDoi = allData["DanhSachTraoDoi"] as List;

      List<TraoDoiPhanAnh> fetchedDanhSachTraoDoiPhanAnh =
          listDanhSachTraoDoi.map((i) => TraoDoiPhanAnh.fromJson(i)).toList();

      if (fetchedDanhSachTraoDoiPhanAnh == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      _danhsachTraoDoiPhanAnh = fetchedDanhSachTraoDoiPhanAnh;
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
mixin ChiTietPhanAnhModel on ConnectedModel {
  ChiTietPhanAnh get chitietPhananh {
    return _chitietPhanAnh;
  }

  Future<Null> fetchChiTietPhanAnh(String phananhid) async {
    _isLoading = true;
    notifyListeners();
    return await http.get(GET_CHITIET_PHANANH_URL + phananhid,
        headers: {'token': token}).then<Null>((http.Response response) {
      var allData = json.decode(response.body);
      ChiTietPhanAnh fetchedChiTietPhanAnh = ChiTietPhanAnh.fromJson(allData);

      if (fetchedChiTietPhanAnh == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      _chitietPhanAnh = fetchedChiTietPhanAnh;
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

mixin DanhSachChoXulyModel on ConnectedModel {
  List<DanhSachChoXuLyPhanAnh> get alldanhsachChoXuLy {
    return List.from(_danhsachChoXuLyPhanAnh);
  }

  Future<Null> fetchDanhSachChoXuLy() async {
    _isLoading = true;
    notifyListeners();
    return await http.get(GET_DANHSACH_CHOXULY_URL,
        headers: {'token': token}).then<Null>((http.Response response) {
      var allData = json.decode(response.body);
      var listDanhSachXuLyPhanAnh=new List();
      listDanhSachXuLyPhanAnh = allData["danh_sach_phan_anh"] as List;
if (listDanhSachXuLyPhanAnh!=null) {
  List<DanhSachChoXuLyPhanAnh> fetchedDanhSachChoXuLyPhanAnh =
  listDanhSachXuLyPhanAnh
      .map((i) => DanhSachChoXuLyPhanAnh.fromJson(i))
      .toList();
  if (fetchedDanhSachChoXuLyPhanAnh == null) {
    _isLoading = false;
    notifyListeners();
    return;
  }
  _danhsachChoXuLyPhanAnh = fetchedDanhSachChoXuLyPhanAnh;
  _isLoading = false;
  notifyListeners();
}
else
  {
    _isLoading = false;
    notifyListeners();
    return;
  }
    }).catchError((error) {
      print(error);
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
mixin ContactDetailModel on ConnectedModel {
  List<ContactDetail> get allContacts {
    return List.from(_contactDetail);
  }

  List<ContactDepartment> get allDeparments {
    return List.from(_contactDepartment);
  }

  Future<Null> fetchContacts(String ownercode) async {
    _isLoading = true;
    notifyListeners();

    return await http.get(GET_CONTACT_URL + ownercode, headers: {
      'Content-Type': 'application/json',
      'username': USERNAME_DEFAULT,
      'password': PASSWORD_DEFAULT
    }).then<Null>((http.Response response) {
      var allData = json.decode(response.body);
      var listofContacts = allData["danhsach_hoso"] as List;
      List<ContactDetail> fetchedContacts =
          listofContacts.map((i) => ContactDetail.fromJson(i)).toList();
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

  Future<Null> fetchContactDepartments() async {
    _isLoading = true;
    notifyListeners();

    return await http.get(GET_CONTACT_DEPARTMENT_URL, headers: {
      'Content-Type': 'application/json',
      'username': USERNAME_DEFAULT,
      'password': PASSWORD_DEFAULT
    }).then<Null>((http.Response response) {
      var allData = json.decode(response.body);
      var listofContactDepartments = allData["TenDonVi"] as List;
      print(listofContactDepartments);
      List<ContactDepartment> fetchedContactDepartment =
          listofContactDepartments
              .map((i) => ContactDepartment.fromJson(i))
              .toList();

      if (fetchedContactDepartment == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      _contactDepartment = fetchedContactDepartment;
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
    try {
      response = await http.post(
        LOGIN_URL,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }
    catch(e)
    {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Lỗi xác thực! Vui lòng thử lại!'};
    }

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
      token=responseData['Token'];
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
    token = prefs.getString('token');
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
