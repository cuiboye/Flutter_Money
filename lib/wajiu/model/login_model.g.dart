// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      json['states'] as int,
      json['msg'] as String?,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'states': instance.states,
      'msg': instance.msg,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      json['area'] as String?,
      json['isAlreadyBuy'] as int,
      json['invalidUser'] as bool,
      json['grade'] as String?,
      Admin.fromJson(json['admin'] as Map<String, dynamic>),
      json['frozenUser'] as bool,
      Fguser.fromJson(json['fguser'] as Map<String, dynamic>),
      json['accountReActive'] as bool,
      json['token'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'area': instance.area,
      'isAlreadyBuy': instance.isAlreadyBuy,
      'invalidUser': instance.invalidUser,
      'grade': instance.grade,
      'admin': instance.admin,
      'frozenUser': instance.frozenUser,
      'fguser': instance.fguser,
      'accountReActive': instance.accountReActive,
      'token': instance.token,
    };

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin(
      json['username'] as String?,
      json['phone'] as String?,
    );

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'username': instance.username,
      'phone': instance.phone,
    };

Fguser _$FguserFromJson(Map<String, dynamic> json) => Fguser(
      json['recentTime'] as int,
      json['userid'] as int,
      json['username'] as String?,
      json['userpass'] as String?,
      (json['userscore'] as num?)?.toDouble(),
      json['province'] as int,
      json['city'] as int,
      json['county'] as int,
      json['enter'] as String?,
      json['loginname'] as String?,
      json['registemark'] as int,
      json['registeName'] as String?,
      json['userAddress'] as String?,
      json['followAUserName'] as String?,
      json['userType'] as int,
      json['createtime'] as int,
      json['lastOrderTime'] as int,
      json['email'] as String?,
      json['phone'] as String?,
      json['address'] as String?,
      json['company'] as String?,
      json['busincharter'] as String?,
      json['businmark'] as String?,
      json['registerip'] as String?,
      json['vipstatus'] as int,
      json['newVipStatus'] as int,
      json['headimg'] as String?,
      json['cardImg'] as String?,
      json['cardnumber'] as String?,
      json['place'] as String?,
      json['infoperfect'] as String?,
      (json['balance'] as num).toDouble(),
      json['firstIp'] as String?,
      json['afterIp'] as String?,
      json['loginTime'] as int,
      json['isConsumption'] as int,
      (json['daibi'] as num).toDouble(),
      json['hasPri'] as bool,
      json['shopType'] as int,
      json['appShow'] as int,
      json['updateTime'] as int,
      json['showSuperMarket'] as int,
      json['statusChanging'] as int,
      json['fieldValidation'] as int,
      json['seaAreaType'] as int,
      json['saleAreaId'] as int,
      json['lastFollowTime'] as int,
      json['returnAreaSeasTime'] as int,
      json['returnSeasTime'] as int,
      json['returnAreaSeaDays'] as int,
      json['legalPerson'] as String?,
      json['accessChannels'] as int,
      json['isIncrement'] as int,
      json['areaTime'] as int,
      json['unsoldReleaseDays'] as String?,
      json['offlineProduct'] as int,
      json['specialUser'] as int,
      json['newVipStatusStr'] as String?,
      UserLinkManage.fromJson(json['userLinkManage'] as Map<String, dynamic>),
      json['isReturnUser'] as int,
      json['foregroundStatusChanging'] as int,
      json['associateWechatStatus'] as int,
      json['waitPayOrder'] as int,
      json['updateSupermarket'] as int,
      json['vipstatusTemp'] as int,
    );

Map<String, dynamic> _$FguserToJson(Fguser instance) => <String, dynamic>{
      'recentTime': instance.recentTime,
      'userid': instance.userid,
      'username': instance.username,
      'userpass': instance.userpass,
      'userscore': instance.userscore,
      'province': instance.province,
      'city': instance.city,
      'county': instance.county,
      'enter': instance.enter,
      'loginname': instance.loginname,
      'registemark': instance.registemark,
      'registeName': instance.registeName,
      'userAddress': instance.userAddress,
      'followAUserName': instance.followAUserName,
      'userType': instance.userType,
      'createtime': instance.createtime,
      'lastOrderTime': instance.lastOrderTime,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'company': instance.company,
      'busincharter': instance.busincharter,
      'businmark': instance.businmark,
      'registerip': instance.registerip,
      'vipstatus': instance.vipstatus,
      'newVipStatus': instance.newVipStatus,
      'headimg': instance.headimg,
      'cardImg': instance.cardImg,
      'cardnumber': instance.cardnumber,
      'place': instance.place,
      'infoperfect': instance.infoperfect,
      'balance': instance.balance,
      'firstIp': instance.firstIp,
      'afterIp': instance.afterIp,
      'loginTime': instance.loginTime,
      'isConsumption': instance.isConsumption,
      'daibi': instance.daibi,
      'hasPri': instance.hasPri,
      'shopType': instance.shopType,
      'appShow': instance.appShow,
      'updateTime': instance.updateTime,
      'showSuperMarket': instance.showSuperMarket,
      'statusChanging': instance.statusChanging,
      'fieldValidation': instance.fieldValidation,
      'seaAreaType': instance.seaAreaType,
      'saleAreaId': instance.saleAreaId,
      'lastFollowTime': instance.lastFollowTime,
      'returnAreaSeasTime': instance.returnAreaSeasTime,
      'returnSeasTime': instance.returnSeasTime,
      'returnAreaSeaDays': instance.returnAreaSeaDays,
      'legalPerson': instance.legalPerson,
      'accessChannels': instance.accessChannels,
      'isIncrement': instance.isIncrement,
      'areaTime': instance.areaTime,
      'unsoldReleaseDays': instance.unsoldReleaseDays,
      'offlineProduct': instance.offlineProduct,
      'specialUser': instance.specialUser,
      'newVipStatusStr': instance.newVipStatusStr,
      'userLinkManage': instance.userLinkManage,
      'isReturnUser': instance.isReturnUser,
      'foregroundStatusChanging': instance.foregroundStatusChanging,
      'associateWechatStatus': instance.associateWechatStatus,
      'waitPayOrder': instance.waitPayOrder,
      'updateSupermarket': instance.updateSupermarket,
      'vipstatusTemp': instance.vipstatusTemp,
    };

UserLinkManage _$UserLinkManageFromJson(Map<String, dynamic> json) =>
    UserLinkManage(
      json['enter'] as String?,
    );

Map<String, dynamic> _$UserLinkManageToJson(UserLinkManage instance) =>
    <String, dynamic>{
      'enter': instance.enter,
    };
