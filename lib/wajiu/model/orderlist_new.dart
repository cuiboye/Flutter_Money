import 'package:json_annotation/json_annotation.dart';

part 'orderlist_new.g.dart';

@JsonSerializable()
class OrdertListNewModel{

  @JsonKey(name: 'msg')
  String? msg;

  @JsonKey(name: 'result')
  Result? result;

  @JsonKey(name: 'states')
  int? states;

  OrdertListNewModel(this.msg,this.result,this.states,);

  factory OrdertListNewModel.fromJson(Map<String, dynamic> srcJson) => _$OrdertListNewModelFromJson(srcJson);
}


@JsonSerializable()
class Result{

  @JsonKey(name: 'delivery')
  List<ListBean?>? delivery;

  Result(this.delivery);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class ListBean {
  @JsonKey(name: 'unionOrderNumber')
  String? unionOrderNumber;

  @JsonKey(name: 'orderStatusStr')
  String? orderStatusStr;

  @JsonKey(name: 'orders')
  List<OrdersBean?>? orders;

  ListBean(this.unionOrderNumber,this.orderStatusStr,this.orders);

  factory ListBean.fromJson(Map<String, dynamic> srcJson) => _$ListBeanFromJson(srcJson);
}

@JsonSerializable()
class OrdersBean {
  @JsonKey(name: 'orderProduct')
  List<OrderListProductBean?>? orderProduct;

  @JsonKey(name: 'orderStatusStr')
  String? orderStatusStr;

  @JsonKey(name: 'orderTotalPriceStr')
  String? orderTotalPriceStr;

  OrdersBean(this.orderProduct,this.orderStatusStr,this.orderTotalPriceStr);

  factory OrdersBean.fromJson(Map<String, dynamic> srcJson) => _$OrdersBeanFromJson(srcJson);
}


@JsonSerializable()
class OrderListProductBean {
  @JsonKey(name: 'cname')
  String? cname;

  @JsonKey(name: 'stringOnePrice')
  String? stringOnePrice;

  @JsonKey(name: 'orderTypeStr')
  String? orderTypeStr;

  @JsonKey(name: 'isJiuZhouBianName')
  String? isJiuZhouBianName;

  @JsonKey(name: 'picture')
  String? picture;

  OrderListProductBean(this.cname,this.stringOnePrice,this.orderTypeStr,this.isJiuZhouBianName,this.picture);

  factory OrderListProductBean.fromJson(Map<String, dynamic> srcJson) => _$OrderListProductBeanFromJson(srcJson);
}