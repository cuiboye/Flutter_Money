import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Sp {
  static Sp? _instance;

  factory Sp() => _instance ?? Sp._();
  SharedPreferences? _prefs;

  Sp._() {
    init();
  }

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<Sp?> perInit() async {
    if (_instance == null) {
      //静态方法不能访问非静态变量所以需要创建变量再通过方法赋值回去
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _instance = Sp._pre(preferences);
    }
    return _instance;
  }

  Sp._pre(SharedPreferences prefs) {
    _prefs = prefs;
  }

  ///设置String类型的
  void setString(key, value) {
    if(value==null) return;
    _prefs?.setString(key, value);
  }

  ///设置setStringList类型的
  void setStringList(key, value) {
    if(value==null) return;
    _prefs?.setStringList(key, value);
  }

  ///设置setBool类型的
  void setBool(key, value) {
    if(value==null) return;
    _prefs?.setBool(key, value);
  }

  ///设置setDouble类型的
  void setDouble(key, value) {
    _prefs?.setDouble(key, value);
  }

  ///设置setInt类型的
  void setInt(key, value) {
    if(value==null) return;
    _prefs?.setInt(key, value);
  }

  ///存储Json类型的
  void setJson(key, value) {
    if(value==null) return;
    value = jsonEncode(value);
    _prefs?.setString(key, value);
  }

  ///通过泛型来获取数据
  T? get<T>(key) {
    var result = _prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }

  ///获取JSON
  Map<String, dynamic>? getJson(key) {
    String? result = _prefs?.getString(key);
    if (result?.isNotEmpty ?? false) {
      return jsonDecode(result!);
    }
    return null;
  }

  ///清除全部
  void clean() {
    _prefs?.clear();
  }

  ///移除某一个
  void remove(key) {
    _prefs?.remove(key);
  }
}
