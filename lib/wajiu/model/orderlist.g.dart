// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdertListModel _$OrdertListModelFromJson(Map<String, dynamic> json) =>
    OrdertListModel(
      json['msg'] as String,
      Result.fromJson(json['result'] as Map<String, dynamic>),
      json['states'] as int,
    );

Map<String, dynamic> _$OrdertListModelToJson(OrdertListModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'result': instance.result,
      'states': instance.states,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['list'] as List<dynamic>)
          .map((e) => ListBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'list': instance.list,
    };

ListBean _$ListBeanFromJson(Map<String, dynamic> json) => ListBean(
      (json['goodsLists'] as List<dynamic>)
          .map((e) => GoodsLists.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalPrice'] as String,
    );

Map<String, dynamic> _$ListBeanToJson(ListBean instance) => <String, dynamic>{
      'goodsLists': instance.goodsLists,
      'totalPrice': instance.totalPrice,
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
