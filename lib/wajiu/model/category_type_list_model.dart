import 'package:json_annotation/json_annotation.dart';

part 'category_type_list_model.g.dart';


@JsonSerializable()
class CategoryTypeListModel{

  @JsonKey(name: 'states')
  int states;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result result;

  CategoryTypeListModel(this.states,this.msg,this.result,);

  factory CategoryTypeListModel.fromJson(Map<String, dynamic> srcJson) => _$CategoryTypeListModelFromJson(srcJson);

}


@JsonSerializable()
class Result{

  @JsonKey(name: 'typeList')
  List<TypeList?> typeList;

  Result(this.typeList,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class TypeList{

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'value')
  String? value;

  @JsonKey(name: 'key')
  String key;

  TypeList(this.name,this.value,this.key,);

  factory TypeList.fromJson(Map<String, dynamic> srcJson) => _$TypeListFromJson(srcJson);

}


