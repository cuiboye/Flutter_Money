import 'package:json_annotation/json_annotation.dart';

part 'wajiu_balance_model.g.dart';


@JsonSerializable()
class WajiuBalanceModel{

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'result')
  Result result;

  @JsonKey(name: 'states')
  int states;

  WajiuBalanceModel(this.msg,this.result,this.states,);

  factory WajiuBalanceModel.fromJson(Map<String, dynamic> srcJson) => _$WajiuBalanceModelFromJson(srcJson);

}


@JsonSerializable()
class Result{

  @JsonKey(name: 'balanceList')
  List<BalanceList> balanceList;

  Result(this.balanceList,);

  factory Result.fromJson(Map<String, dynamic> srcJson) => _$ResultFromJson(srcJson);

}


@JsonSerializable()
class BalanceList{

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'money')
  String money;

  @JsonKey(name: 'time')
  String time;

  BalanceList(this.content,this.money,this.time,);

  factory BalanceList.fromJson(Map<String, dynamic> srcJson) => _$BalanceListFromJson(srcJson);

}


