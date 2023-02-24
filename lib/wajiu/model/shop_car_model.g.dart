// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopCarModel _$ShopCarModelFromJson(Map<String, dynamic> json) => ShopCarModel(
      json['msg'] as String,
      Result.fromJson(json['result'] as Map<String, dynamic>),
      json['states'] as int,
    );

Map<String, dynamic> _$ShopCarModelToJson(ShopCarModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'result': instance.result,
      'states': instance.states,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['shopCarList'] as List<dynamic>)
          .map((e) => ShopCarList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'shopCarList': instance.shopCarList,
    };

ShopCarList _$ShopCarListFromJson(Map<String, dynamic> json) => ShopCarList(
      json['fathername'] as String,
    );

Map<String, dynamic> _$ShopCarListToJson(ShopCarList instance) =>
    <String, dynamic>{
      'fathername': instance.fathername,
    };
