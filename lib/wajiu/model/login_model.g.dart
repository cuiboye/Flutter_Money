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
    );

Map<String, dynamic> _$FguserToJson(Fguser instance) => <String, dynamic>{
      'recentTime': instance.recentTime,
    };

UserLinkManage _$UserLinkManageFromJson(Map<String, dynamic> json) =>
    UserLinkManage(
      json['enter'] as String?,
    );

Map<String, dynamic> _$UserLinkManageToJson(UserLinkManage instance) =>
    <String, dynamic>{
      'enter': instance.enter,
    };
