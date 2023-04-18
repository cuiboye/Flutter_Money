// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_mainpage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeMainPageModel _$HomeMainPageModelFromJson(Map<String, dynamic> json) =>
    HomeMainPageModel(
      json['msg'] as String,
      Result.fromJson(json['result'] as Map<String, dynamic>),
      json['states'] as int,
    );

Map<String, dynamic> _$HomeMainPageModelToJson(HomeMainPageModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'result': instance.result,
      'states': instance.states,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result();

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{};
