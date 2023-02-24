import 'package:json_annotation/json_annotation.dart';

part 'shop_car_model.g.dart';


@JsonSerializable()
class ShopCarModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'states')
  int states;

  ShopCarModel(this.msg,this.result,this.states,);

  factory ShopCarModel.fromJson(Map<String, dynamic> srcJson) => _$ShopCarModelFromJson(srcJson);

}


@JsonSerializable()
class Result{

  @JsonKey(name: 'shopCarList')
  List<ShopCarList> shopCarList;

  Result(this.shopCarList,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class ShopCarList{

  @JsonKey(name: 'fathername')
  String fathername;

  ShopCarList(this.fathername,);

  factory ShopCarList.fromJson(Map<String, dynamic> srcJson) => _$ShopCarListFromJson(srcJson);

}


