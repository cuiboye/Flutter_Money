import 'package:json_annotation/json_annotation.dart';

part 'order_list_item_data_model.g.dart';

@JsonSerializable()
class OrderListItemDataModel {
  @JsonKey(name: 'states')
  int? states;

  @JsonKey(name: 'result')
  Result? result;

  OrderListItemDataModel({
    this.states,
    this.result,
  });

  factory OrderListItemDataModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderListItemDataModelFromJson(srcJson);
}

@JsonSerializable()
class Result {
  @JsonKey(name: 'delivery')
  List<Delivery> delivery;

  Result(this.delivery);

  factory Result.fromJson(Map<String, dynamic> srcJson) =>
      _$ResultFromJson(srcJson);
}

@JsonSerializable()
class Delivery {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'unionOrderNumber')
  String unionOrderNumber;

  // @JsonKey(name: 'orders')
  // List<Orders> orders;

  Delivery(this.id, this.unionOrderNumber);

  factory Delivery.fromJson(Map<String, dynamic> srcJson) =>
      _$DeliveryFromJson(srcJson);
}
