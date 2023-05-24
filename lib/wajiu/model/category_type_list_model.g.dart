// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_type_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryTypeListModel _$CategoryTypeListModelFromJson(
        Map<String, dynamic> json) =>
    CategoryTypeListModel(
      json['states'] as int,
      json['msg'] as String,
      Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryTypeListModelToJson(
        CategoryTypeListModel instance) =>
    <String, dynamic>{
      'states': instance.states,
      'msg': instance.msg,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['typeList'] as List<dynamic>)
          .map((e) =>
              e == null ? null : TypeList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'typeList': instance.typeList,
    };

TypeList _$TypeListFromJson(Map<String, dynamic> json) => TypeList(
      json['name'] as String?,
      json['value'] as String?,
      json['key'] as String,
    );

Map<String, dynamic> _$TypeListToJson(TypeList instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'key': instance.key,
    };
