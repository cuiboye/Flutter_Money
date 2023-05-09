// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_productlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeProductListModel _$HomeProductListModelFromJson(
        Map<String, dynamic> json) =>
    HomeProductListModel(
      json['states'] as int,
      json['msg'] as String,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeProductListModelToJson(
        HomeProductListModel instance) =>
    <String, dynamic>{
      'states': instance.states,
      'msg': instance.msg,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      json['isLogin'] as int,
      (json['productList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : HotWorldProductList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'isLogin': instance.isLogin,
      'productList': instance.productList,
    };

HotWorldProductList _$HotWorldProductListFromJson(Map<String, dynamic> json) =>
    HotWorldProductList(
      json['productId'] as int,
      json['cname'] as String?,
      json['ename'] as String?,
      json['picture'] as String?,
      (json['jnPrice'] as num).toDouble(),
      json['countryName'] as String?,
      json['grade'] as String?,
      json['parameter'] as String,
    );

Map<String, dynamic> _$HotWorldProductListToJson(
        HotWorldProductList instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'cname': instance.cname,
      'ename': instance.ename,
      'picture': instance.picture,
      'jnPrice': instance.jnPrice,
      'countryName': instance.countryName,
      'grade': instance.grade,
      'parameter': instance.parameter,
    };
