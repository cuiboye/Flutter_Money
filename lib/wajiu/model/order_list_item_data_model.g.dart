// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_item_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListItemDataModel _$OrderListItemDataModelFromJson(
        Map<String, dynamic> json) =>
    OrderListItemDataModel(
      states: json['states'] as int?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderListItemDataModelToJson(
        OrderListItemDataModel instance) =>
    <String, dynamic>{
      'states': instance.states,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['delivery'] as List<dynamic>)
          .map((e) => Delivery.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'delivery': instance.delivery,
    };

Delivery _$DeliveryFromJson(Map<String, dynamic> json) => Delivery(
      json['id'] as int,
      json['unionOrderNumber'] as String,
    );

Map<String, dynamic> _$DeliveryToJson(Delivery instance) => <String, dynamic>{
      'id': instance.id,
      'unionOrderNumber': instance.unionOrderNumber,
    };
