import 'package:json_annotation/json_annotation.dart';

part 'orderlist_new.g.dart';

@JsonSerializable()
class OrdertListNewModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result? result;

  @JsonKey(name: 'states')
  int states;

  OrdertListNewModel(this.msg,this.result,this.states,);

  factory OrdertListNewModel.fromJson(Map<String, dynamic> srcJson) => _$OrdertListNewModelFromJson(srcJson);
}


@JsonSerializable()
class Result{

  @JsonKey(name: 'delivery')
  List<ListBean>? delivery;

  Result(this.delivery);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class ListBean {

  // @JsonKey(name: 'goodsLists')
  // List<GoodsLists> goodsLists;

  @JsonKey(name: 'unionOrderNumber')
  String unionOrderNumber;

  ListBean(this.unionOrderNumber);

  factory ListBean.fromJson(Map<String, dynamic> srcJson) => _$ListBeanFromJson(srcJson);

}


@JsonSerializable()
class GoodsLists{

  @JsonKey(name: 'beforePrice')
  String beforePrice;

  @JsonKey(name: 'currentPrice')
  String currentPrice;

  @JsonKey(name: 'goodsName')
  String goodsName;

  @JsonKey(name: 'imagePath')
  String imagePath;

  @JsonKey(name: 'type')
  int type;

  GoodsLists(this.beforePrice,this.currentPrice,this.goodsName,this.imagePath,this.type,);

  factory GoodsLists.fromJson(Map<String, dynamic> srcJson) => _$GoodsListsFromJson(srcJson);

}


