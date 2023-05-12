import 'package:json_annotation/json_annotation.dart';

part 'mingzhuangxianhuo_product_list_model.g.dart';


@JsonSerializable()
class MingzhuangxianhuoProductListModel{

  @JsonKey(name: 'states')
  int states;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result result;

  MingzhuangxianhuoProductListModel(this.states,this.msg,this.result,);

  factory MingzhuangxianhuoProductListModel.fromJson(Map<String, dynamic> srcJson) => _$MingzhuangxianhuoProductListModelFromJson(srcJson);

}


@JsonSerializable()
class Result{

  @JsonKey(name: 'isLogin')
  int isLogin;

  @JsonKey(name: 'noticelist')
  List<Noticelist?>? noticelist;

  @JsonKey(name: 'productlist')
  List<Productlist?>? productlist;

  Result(this.isLogin,this.noticelist,this.productlist);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class Noticelist{

  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'parameter')
  String parameter;

  Noticelist(this.picture,this.parameter,);

  factory Noticelist.fromJson(Map<String, dynamic> srcJson) => _$NoticelistFromJson(srcJson);

}


@JsonSerializable()
class Productlist{

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'cname')
  String? cname;

  @JsonKey(name: 'ename')
  String? ename;

  @JsonKey(name: 'description1')
  String? description1;

  @JsonKey(name: 'picture')
  String? picture;

  @JsonKey(name: 'replenishMent')
  int replenishMent;

  @JsonKey(name: 'operate')
  Operate operate;

  Productlist(this.id,this.cname,this.ename,this.description1,this.picture,this.replenishMent,this.operate,);

  factory Productlist.fromJson(Map<String, dynamic> srcJson) => _$ProductlistFromJson(srcJson);

}

@JsonSerializable()
class Operate{

  @JsonKey(name: 'jnJudgeStock')
  int jnJudgeStock;

  @JsonKey(name: 'jnPrice')
  double jnPrice;

  @JsonKey(name: 'productStorage')
  ProductStorage productStorage;

  Operate(this.jnJudgeStock,this.jnPrice,this.productStorage,);

  factory Operate.fromJson(Map<String, dynamic> srcJson) => _$OperateFromJson(srcJson);

}


@JsonSerializable()
class ProductStorage{

  @JsonKey(name: 'jnStock')
  int jnStock;

  ProductStorage(this.jnStock,);

  factory ProductStorage.fromJson(Map<String, dynamic> srcJson) => _$ProductStorageFromJson(srcJson);

}


