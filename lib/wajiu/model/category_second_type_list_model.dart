import 'package:flutter_money/wajiu/model/orderlist.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_second_type_list_model.g.dart';


@JsonSerializable()
class CategorySecondTypeListModel {

  @JsonKey(name: 'states')
  int? states;

  @JsonKey(name: 'msg')
  String? msg;

  @JsonKey(name: 'result')
  Result? result;

  CategorySecondTypeListModel(this.states,this.msg,this.result,);

  factory CategorySecondTypeListModel.fromJson(Map<String, dynamic> srcJson) => _$CategorySecondTypeListModelFromJson(srcJson);

}


@JsonSerializable()
class Result {

  @JsonKey(name: 'bannerList')
  List<BannerList>? bannerList;

  @JsonKey(name: 'parameterList')
  List<ParameterList?>? parameterList;

  Result(this.bannerList,this.parameterList);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);
}


@JsonSerializable()
class BannerList{

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'value')
  String? value;

  BannerList(this.name,this.value,);

  factory BannerList.fromJson(Map<String, dynamic> srcJson) => _$BannerListFromJson(srcJson);

}


@JsonSerializable()
class ParameterList{

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'list')
  List<ListBean?>? list;

  @JsonKey(name: 'reqName')
  String? reqName;

  @JsonKey(name: 'type')
  int? type;

  ParameterList(this.title,this.list,this.reqName,this.type,this.name);

  factory ParameterList.fromJson(Map<String, dynamic> srcJson) => _$ParameterListFromJson(srcJson);

}


@JsonSerializable()
class ListBean{

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'value')
  dynamic? value;

  @JsonKey(name: 'hotFlag')
  int? hotFlag;

  ListBean(this.name,this.value,this.hotFlag);

  factory ListBean.fromJson(Map<String, dynamic> srcJson) => _$ListBeanFromJson(srcJson);

}


