// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mingzhuangxianhuo_product_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MingzhuangxianhuoProductListModel _$MingzhuangxianhuoProductListModelFromJson(
        Map<String, dynamic> json) =>
    MingzhuangxianhuoProductListModel(
      json['states'] as int,
      json['msg'] as String,
      Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MingzhuangxianhuoProductListModelToJson(
        MingzhuangxianhuoProductListModel instance) =>
    <String, dynamic>{
      'states': instance.states,
      'msg': instance.msg,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      json['isLogin'] as int,
      (json['noticelist'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Noticelist.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['productlist'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Productlist.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'isLogin': instance.isLogin,
      'noticelist': instance.noticelist,
      'productlist': instance.productlist,
    };

Noticelist _$NoticelistFromJson(Map<String, dynamic> json) => Noticelist(
      json['picture'] as String?,
      json['parameter'] as String,
    );

Map<String, dynamic> _$NoticelistToJson(Noticelist instance) =>
    <String, dynamic>{
      'picture': instance.picture,
      'parameter': instance.parameter,
    };

Productlist _$ProductlistFromJson(Map<String, dynamic> json) => Productlist(
      json['id'] as String,
      json['cname'] as String?,
      json['ename'] as String?,
      json['description1'] as String?,
      json['picture'] as String?,
      json['replenishMent'] as int,
      Operate.fromJson(json['operate'] as Map<String, dynamic>),
      json['jnPrice'] as String?,
    );

Map<String, dynamic> _$ProductlistToJson(Productlist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cname': instance.cname,
      'ename': instance.ename,
      'description1': instance.description1,
      'picture': instance.picture,
      'jnPrice': instance.jnPrice,
      'replenishMent': instance.replenishMent,
      'operate': instance.operate,
    };

Operate _$OperateFromJson(Map<String, dynamic> json) => Operate(
      json['jnJudgeStock'] as int,
      (json['jnPrice'] as num).toDouble(),
      ProductStorage.fromJson(json['productStorage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OperateToJson(Operate instance) => <String, dynamic>{
      'jnJudgeStock': instance.jnJudgeStock,
      'jnPrice': instance.jnPrice,
      'productStorage': instance.productStorage,
    };

ProductStorage _$ProductStorageFromJson(Map<String, dynamic> json) =>
    ProductStorage(
      json['jnStock'] as int,
    );

Map<String, dynamic> _$ProductStorageToJson(ProductStorage instance) =>
    <String, dynamic>{
      'jnStock': instance.jnStock,
    };
