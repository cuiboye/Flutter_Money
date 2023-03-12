import 'package:json_annotation/json_annotation.dart';

part 'joined_product_list_model.g.dart';


@JsonSerializable()
class JoinedProductListModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'states')
  int states;

  JoinedProductListModel(this.msg,this.result,this.states,);

  factory JoinedProductListModel.fromJson(Map<String, dynamic> srcJson) => _$JoinedProductListModelFromJson(srcJson);

}


@JsonSerializable()
class Result{

  @JsonKey(name: 'shopcarList')
  List<ShopcarList> shopcarList;

  Result(this.shopcarList,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class ShopcarList{

  @JsonKey(name: 'cangkuid')
  int cangkuid;

  @JsonKey(name: 'fathername')
  String? fathername;

  @JsonKey(name: 'productList')
  List<ProductList?>? productList;

  @JsonKey(name: 'totalSelected')
  bool totalSelected;

  ShopcarList(this.cangkuid,this.fathername,this.productList,this.totalSelected,);

  factory ShopcarList.fromJson(Map<String, dynamic> srcJson) => _$ShopcarListFromJson(srcJson);

}


@JsonSerializable()
class ProductList{

  @JsonKey(name: 'cangkuid')
  int cangkuid;

  @JsonKey(name: 'joinshoapcar')
  int joinshoapcar;

  @JsonKey(name: 'productid')
  int productid;

  @JsonKey(name: 'selected')
  int selected;

  @JsonKey(name: 'productname')
  String productname;

  ProductList(this.cangkuid,this.joinshoapcar,this.productid,this.selected,this.productname);

  factory ProductList.fromJson(Map<String, dynamic> srcJson) => _$ProductListFromJson(srcJson);

}


