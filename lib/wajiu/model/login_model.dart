import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  @JsonKey(name: 'states')
  int states;

  @JsonKey(name: 'msg')
  String? msg;

  @JsonKey(name: 'result')
  Result? result;

  LoginModel(
    this.states,
    this.msg,
    this.result,
  );

  factory LoginModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginModelFromJson(srcJson);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'area')
  String? area;

  @JsonKey(name: 'isAlreadyBuy')
  int isAlreadyBuy;

  @JsonKey(name: 'invalidUser')
  bool invalidUser;

  @JsonKey(name: 'grade')
  String? grade;

  @JsonKey(name: 'admin')
  Admin admin;

  @JsonKey(name: 'frozenUser')
  bool frozenUser;

  @JsonKey(name: 'fguser')
  Fguser fguser;

  @JsonKey(name: 'accountReActive')
  bool accountReActive;

  @JsonKey(name: 'token')
  String? token;

  Result(
    this.area,
    this.isAlreadyBuy,
    this.invalidUser,
    this.grade,
    this.admin,
    this.frozenUser,
    this.fguser,
    this.accountReActive,
    this.token,
  );

  factory Result.fromJson(Map<String, dynamic> srcJson) =>
      _$ResultFromJson(srcJson);
}

@JsonSerializable()
class Admin {
  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'phone')
  String? phone;

  Admin(
    this.username,
    this.phone,
  );

  factory Admin.fromJson(Map<String, dynamic> srcJson) =>
      _$AdminFromJson(srcJson);
}

@JsonSerializable()
class Fguser {
  @JsonKey(name: 'recentTime')
  int recentTime;
  Fguser(this.recentTime);

  factory Fguser.fromJson(Map<String, dynamic> srcJson) =>
      _$FguserFromJson(srcJson);
}

@JsonSerializable()
class UserLinkManage {
  @JsonKey(name: 'enter')
  String? enter;

  UserLinkManage(
    this.enter,
  );

  factory UserLinkManage.fromJson(Map<String, dynamic> srcJson) =>
      _$UserLinkManageFromJson(srcJson);
}
