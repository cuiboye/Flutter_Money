// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_second_type_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategorySecondTypeListModel _$CategorySecondTypeListModelFromJson(
        Map<String, dynamic> json) =>
    CategorySecondTypeListModel(
      json['states'] as int?,
      json['msg'] as String?,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategorySecondTypeListModelToJson(
        CategorySecondTypeListModel instance) =>
    <String, dynamic>{
      'states': instance.states,
      'msg': instance.msg,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['bannerList'] as List<dynamic>?)
          ?.map((e) => BannerList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['parameterList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ParameterList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'bannerList': instance.bannerList,
      'parameterList': instance.parameterList,
    };

BannerList _$BannerListFromJson(Map<String, dynamic> json) => BannerList(
      json['name'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$BannerListToJson(BannerList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

ParameterList _$ParameterListFromJson(Map<String, dynamic> json) =>
    ParameterList(
      json['title'] as String?,
      (json['list'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : ListBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['reqName'] as String?,
      json['type'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$ParameterListToJson(ParameterList instance) =>
    <String, dynamic>{
      'title': instance.title,
      'name': instance.name,
      'list': instance.list,
      'reqName': instance.reqName,
      'type': instance.type,
    };

ListBean _$ListBeanFromJson(Map<String, dynamic> json) => ListBean(
      json['name'] as String?,
      json['value'],
      json['hotFlag'] as int?,
    );

Map<String, dynamic> _$ListBeanToJson(ListBean instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'hotFlag': instance.hotFlag,
    };
