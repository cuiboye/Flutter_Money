import 'package:json_annotation/json_annotation.dart';

part 'home_productlist_model.g.dart';

@JsonSerializable()
class HomeProductListModel{

  @JsonKey(name: 'states')
  int states;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result? result;

  HomeProductListModel(this.states,this.msg,this.result,);

  factory HomeProductListModel.fromJson(Map<String, dynamic> srcJson) => _$HomeProductListModelFromJson(srcJson);

}


@JsonSerializable()
class Result{

  @JsonKey(name: 'isLogin')
  int isLogin;

  @JsonKey(name: 'productList')
  List<HotWorldProductList?>? productList;

  Result(this.isLogin,this.productList,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class HotWorldProductList{

  @JsonKey(name: 'productId')
  int productId;

  @JsonKey(name: 'cname')
  String? cname;

  @JsonKey(name: 'ename')
  String? ename;

  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'jnPrice')
  double jnPrice;

  @JsonKey(name: 'countryName')
  String? countryName;

  @JsonKey(name: 'grade')
  String? grade;

  @JsonKey(name: 'parameter')
  String parameter;

  HotWorldProductList(this.productId,this.cname,this.ename,this.picture,this.jnPrice,this.countryName,this.grade,this.parameter,);

  factory HotWorldProductList.fromJson(Map<String, dynamic> srcJson) => _$HotWorldProductListFromJson(srcJson);
}