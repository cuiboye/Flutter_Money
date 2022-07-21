// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListModel _$ProductListModelFromJson(Map<String, dynamic> json) =>
    ProductListModel(
      json['msg'] as String,
      Result.fromJson(json['result'] as Map<String, dynamic>),
      json['states'] as int,
    );

Map<String, dynamic> _$ProductListModelToJson(ProductListModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'result': instance.result,
      'states': instance.states,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['list'] as List<dynamic>)
          .map((e) => ListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['startTime'] as String,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'list': instance.list,
      'startTime': instance.startTime,
    };

ListData _$ListDataFromJson(Map<String, dynamic> json) => ListData(
      json['beforePrice'] as String,
      json['currentPrice'] as String,
      json['descript'] as String,
      json['imageUrl'] as String,
      json['productName'] as String,
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['type'] as int,
    );

Map<String, dynamic> _$ListDataToJson(ListData instance) => <String, dynamic>{
      'beforePrice': instance.beforePrice,
      'currentPrice': instance.currentPrice,
      'descript': instance.descript,
      'imageUrl': instance.imageUrl,
      'productName': instance.productName,
      'tags': instance.tags,
      'type': instance.type,
    };
