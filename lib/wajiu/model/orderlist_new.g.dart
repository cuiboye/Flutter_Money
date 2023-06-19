// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderlist_new.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdertListNewModel _$OrdertListNewModelFromJson(Map<String, dynamic> json) =>
    OrdertListNewModel(
      json['msg'] as String?,
      json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      json['states'] as int?,
    );

Map<String, dynamic> _$OrdertListNewModelToJson(OrdertListNewModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'result': instance.result,
      'states': instance.states,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['delivery'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : ListBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'delivery': instance.delivery,
    };

ListBean _$ListBeanFromJson(Map<String, dynamic> json) => ListBean(
      json['unionOrderNumber'] as String?,
      json['orderStatusStr'] as String?,
      (json['orders'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : OrdersBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListBeanToJson(ListBean instance) => <String, dynamic>{
      'unionOrderNumber': instance.unionOrderNumber,
      'orderStatusStr': instance.orderStatusStr,
      'orders': instance.orders,
    };

OrdersBean _$OrdersBeanFromJson(Map<String, dynamic> json) => OrdersBean(
      (json['orderProduct'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : OrderListProductBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['orderStatusStr'] as String?,
      json['orderTotalPriceStr'] as String?,
    );

Map<String, dynamic> _$OrdersBeanToJson(OrdersBean instance) =>
    <String, dynamic>{
      'orderProduct': instance.orderProduct,
      'orderStatusStr': instance.orderStatusStr,
      'orderTotalPriceStr': instance.orderTotalPriceStr,
    };

OrderListProductBean _$OrderListProductBeanFromJson(
        Map<String, dynamic> json) =>
    OrderListProductBean(
      json['cname'] as String?,
      json['stringOnePrice'] as String?,
      json['orderTypeStr'] as String?,
      json['isJiuZhouBianName'] as String?,
      json['picture'] as String?,
    );

Map<String, dynamic> _$OrderListProductBeanToJson(
        OrderListProductBean instance) =>
    <String, dynamic>{
      'cname': instance.cname,
      'stringOnePrice': instance.stringOnePrice,
      'orderTypeStr': instance.orderTypeStr,
      'isJiuZhouBianName': instance.isJiuZhouBianName,
      'picture': instance.picture,
    };
