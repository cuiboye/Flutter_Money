// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonRequestModel _$CommonRequestModelFromJson(Map<String, dynamic> json) =>
    CommonRequestModel(
      json['msg'] as String,
      json['states'] as int,
    );

Map<String, dynamic> _$CommonRequestModelToJson(CommonRequestModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'states': instance.states,
    };
