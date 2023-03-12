// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joined_product_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinedProductListModel _$JoinedProductListModelFromJson(
        Map<String, dynamic> json) =>
    JoinedProductListModel(
      json['msg'] as String,
      Result.fromJson(json['result'] as Map<String, dynamic>),
      json['states'] as int,
    );

Map<String, dynamic> _$JoinedProductListModelToJson(
        JoinedProductListModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'result': instance.result,
      'states': instance.states,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['shopcarList'] as List<dynamic>)
          .map((e) => ShopcarList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'shopcarList': instance.shopcarList,
    };

ShopcarList _$ShopcarListFromJson(Map<String, dynamic> json) => ShopcarList(
      json['cangkuid'] as int,
      json['fathername'] as String?,
      (json['productList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ProductList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['totalSelected'] as bool,
    );

Map<String, dynamic> _$ShopcarListToJson(ShopcarList instance) =>
    <String, dynamic>{
      'cangkuid': instance.cangkuid,
      'fathername': instance.fathername,
      'productList': instance.productList,
      'totalSelected': instance.totalSelected,
    };

ProductList _$ProductListFromJson(Map<String, dynamic> json) => ProductList(
      json['cangkuid'] as int,
      json['joinshoapcar'] as int,
      json['productid'] as int,
      json['selected'] as int,
      json['productname'] as String,
    );

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{
      'cangkuid': instance.cangkuid,
      'joinshoapcar': instance.joinshoapcar,
      'productid': instance.productid,
      'selected': instance.selected,
      'productname': instance.productname,
    };
