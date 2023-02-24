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
      (json['productList'] as List<dynamic>)
          .map((e) => ProductList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'productList': instance.productList,
    };

ProductList _$ProductListFromJson(Map<String, dynamic> json) => ProductList(
      json['productid'] as int,
      json['joinshoapcar'] as int,
      json['cangkuId'] as int,
      json['productName'] as String,
    );

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'productid': instance.productid,
      'joinshoapcar': instance.joinshoapcar,
      'cangkuId': instance.cangkuId,
      'productName': instance.productName,
    };
