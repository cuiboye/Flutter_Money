// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderlist_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdertListNewModel _$OrdertListNewModelFromJson(Map<String, dynamic> json) =>
    OrdertListNewModel(
      json['msg'] as String,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      json['states'] as int,
    );

Map<String, dynamic> _$OrdertListNewModelToJson(OrdertListNewModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'result': instance.result,
      'states': instance.states,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['delivery'] as List<dynamic>?)
          ?.map((e) => ListBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'delivery': instance.delivery,
    };

ListBean _$ListBeanFromJson(Map<String, dynamic> json) => ListBean(
      json['unionOrderNumber'] as String,
    );

Map<String, dynamic> _$ListBeanToJson(ListBean instance) => <String, dynamic>{
      'unionOrderNumber': instance.unionOrderNumber,
    };

GoodsLists _$GoodsListsFromJson(Map<String, dynamic> json) => GoodsLists(
      json['beforePrice'] as String,
      json['currentPrice'] as String,
      json['goodsName'] as String,
      json['imagePath'] as String,
      json['type'] as int,
    );

Map<String, dynamic> _$GoodsListsToJson(GoodsLists instance) =>
    <String, dynamic>{
      'beforePrice': instance.beforePrice,
      'currentPrice': instance.currentPrice,
      'goodsName': instance.goodsName,
      'imagePath': instance.imagePath,
      'type': instance.type,
    };
