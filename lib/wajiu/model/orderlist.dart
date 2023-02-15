import 'package:json_annotation/json_annotation.dart';

part 'orderlist.g.dart';

@JsonSerializable()
class OrdertListModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'states')
  int states;

  OrdertListModel(this.msg,this.result,this.states,);

  factory OrdertListModel.fromJson(Map<String, dynamic> srcJson) => _$OrdertListModelFromJson(srcJson);
}


@JsonSerializable()
class Result{

  @JsonKey(name: 'list')
  List<ListBean> list;

  Result(this.list,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class ListBean {

  @JsonKey(name: 'goodsLists')
  List<GoodsLists> goodsLists;

  @JsonKey(name: 'totalPrice')
  String totalPrice;

  ListBean(this.goodsLists,this.totalPrice,);

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


