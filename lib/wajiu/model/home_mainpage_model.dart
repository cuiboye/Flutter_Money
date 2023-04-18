import 'package:json_annotation/json_annotation.dart';

part 'home_mainpage_model.g.dart';


@JsonSerializable()
class HomeMainPageModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'states')
  int states;

  HomeMainPageModel(this.msg,this.result,this.states,);

  factory HomeMainPageModel.fromJson(Map<String, dynamic> srcJson) => _$HomeMainPageModelFromJson(srcJson);
}


@JsonSerializable()
class Result{

  // @JsonKey(name: 'productList')
  // List<ProductList> productList;
  //
  // Result(this.productList,);
  //
  // factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);
}


// @JsonSerializable()
// class ProductList{
//   @JsonKey(name: 'productid')
//   int productid;
//
//   @JsonKey(name: 'joinshoapcar')
//   int joinshoapcar;
//
//   @JsonKey(name: 'cangkuId')
//   int cangkuId;
//
//   @JsonKey(name: 'productName')
//   String productName;
//
//   ProductList(this.productid,this.joinshoapcar,this.cangkuId,this.productName,);
//
//   factory ProductList.fromJson(Map<String, dynamic> srcJson) => _$ProductListFromJson(srcJson);
//
// }