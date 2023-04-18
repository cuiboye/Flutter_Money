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

  @JsonKey(name: 'userid')
  int userid;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'userpass')
  String? userpass;

  @JsonKey(name: 'userscore')
  double? userscore;

  @JsonKey(name: 'province')
  int province;

  @JsonKey(name: 'city')
  int city;

  @JsonKey(name: 'county')
  int county;

  @JsonKey(name: 'enter')
  String? enter;

  @JsonKey(name: 'loginname')
  String? loginname;

  @JsonKey(name: 'registemark')
  int registemark;

  @JsonKey(name: 'registeName')
  String? registeName;

  @JsonKey(name: 'userAddress')
  String? userAddress;

  @JsonKey(name: 'followAUserName')
  String? followAUserName;

  @JsonKey(name: 'userType')
  int userType;

  @JsonKey(name: 'createtime')
  int createtime;

  @JsonKey(name: 'lastOrderTime')
  int lastOrderTime;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'company')
  String? company;

  @JsonKey(name: 'busincharter')
  String? busincharter;

  @JsonKey(name: 'businmark')
  String? businmark;

  @JsonKey(name: 'registerip')
  String? registerip;

  @JsonKey(name: 'vipstatus')
  int vipstatus;

  @JsonKey(name: 'newVipStatus')
  int newVipStatus;

  @JsonKey(name: 'headimg')
  String? headimg;

  @JsonKey(name: 'cardImg')
  String? cardImg;

  @JsonKey(name: 'cardnumber')
  String? cardnumber;

  @JsonKey(name: 'place')
  String? place;

  @JsonKey(name: 'infoperfect')
  String? infoperfect;

  @JsonKey(name: 'balance')
  double balance;

  @JsonKey(name: 'firstIp')
  String? firstIp;

  @JsonKey(name: 'afterIp')
  String? afterIp;

  @JsonKey(name: 'loginTime')
  int loginTime;

  @JsonKey(name: 'isConsumption')
  int isConsumption;

  @JsonKey(name: 'daibi')
  double daibi;

  @JsonKey(name: 'hasPri')
  bool hasPri;

  @JsonKey(name: 'shopType')
  int shopType;

  @JsonKey(name: 'appShow')
  int appShow;

  @JsonKey(name: 'updateTime')
  int updateTime;

  @JsonKey(name: 'showSuperMarket')
  int showSuperMarket;

  @JsonKey(name: 'statusChanging')
  int statusChanging;

  @JsonKey(name: 'fieldValidation')
  int fieldValidation;

  @JsonKey(name: 'seaAreaType')
  int seaAreaType;

  @JsonKey(name: 'saleAreaId')
  int saleAreaId;

  @JsonKey(name: 'lastFollowTime')
  int lastFollowTime;

  @JsonKey(name: 'returnAreaSeasTime')
  int returnAreaSeasTime;

  @JsonKey(name: 'returnSeasTime')
  int returnSeasTime;

  @JsonKey(name: 'returnAreaSeaDays')
  int returnAreaSeaDays;

  @JsonKey(name: 'legalPerson')
  String? legalPerson;

  @JsonKey(name: 'accessChannels')
  int accessChannels;

  @JsonKey(name: 'isIncrement')
  int isIncrement;

  @JsonKey(name: 'areaTime')
  int areaTime;

  @JsonKey(name: 'unsoldReleaseDays')
  String? unsoldReleaseDays;

  @JsonKey(name: 'offlineProduct')
  int offlineProduct;

  @JsonKey(name: 'specialUser')
  int specialUser;

  @JsonKey(name: 'newVipStatusStr')
  String? newVipStatusStr;

  @JsonKey(name: 'userLinkManage')
  UserLinkManage userLinkManage;

  @JsonKey(name: 'isReturnUser')
  int isReturnUser;

  @JsonKey(name: 'foregroundStatusChanging')
  int foregroundStatusChanging;

  @JsonKey(name: 'associateWechatStatus')
  int associateWechatStatus;

  @JsonKey(name: 'waitPayOrder')
  int waitPayOrder;

  @JsonKey(name: 'updateSupermarket')
  int updateSupermarket;

  @JsonKey(name: 'vipstatusTemp')
  int vipstatusTemp;

  Fguser(
    this.recentTime,
    this.userid,
    this.username,
    this.userpass,
    this.userscore,
    this.province,
    this.city,
    this.county,
    this.enter,
    this.loginname,
    this.registemark,
    this.registeName,
    this.userAddress,
    this.followAUserName,
    this.userType,
    this.createtime,
    this.lastOrderTime,
    this.email,
    this.phone,
    this.address,
    this.company,
    this.busincharter,
    this.businmark,
    this.registerip,
    this.vipstatus,
    this.newVipStatus,
    this.headimg,
    this.cardImg,
    this.cardnumber,
    this.place,
    this.infoperfect,
    this.balance,
    this.firstIp,
    this.afterIp,
    this.loginTime,
    this.isConsumption,
    this.daibi,
    this.hasPri,
    this.shopType,
    this.appShow,
    this.updateTime,
    this.showSuperMarket,
    this.statusChanging,
    this.fieldValidation,
    this.seaAreaType,
    this.saleAreaId,
    this.lastFollowTime,
    this.returnAreaSeasTime,
    this.returnSeasTime,
    this.returnAreaSeaDays,
    this.legalPerson,
    this.accessChannels,
    this.isIncrement,
    this.areaTime,
    this.unsoldReleaseDays,
    this.offlineProduct,
    this.specialUser,
    this.newVipStatusStr,
    this.userLinkManage,
    this.isReturnUser,
    this.foregroundStatusChanging,
    this.associateWechatStatus,
    this.waitPayOrder,
    this.updateSupermarket,
    this.vipstatusTemp,
  );

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
