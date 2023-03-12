// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wajiu_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WajiuBalanceModel _$WajiuBalanceModelFromJson(Map<String, dynamic> json) =>
    WajiuBalanceModel(
      json['msg'] as String,
      Result.fromJson(json['result'] as Map<String, dynamic>),
      json['states'] as int,
    );

Map<String, dynamic> _$WajiuBalanceModelToJson(WajiuBalanceModel instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'result': instance.result,
      'states': instance.states,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      (json['balanceList'] as List<dynamic>)
          .map((e) => BalanceList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'balanceList': instance.balanceList,
    };

BalanceList _$BalanceListFromJson(Map<String, dynamic> json) => BalanceList(
      json['content'] as String,
      json['money'] as String,
      json['time'] as String,
    );

Map<String, dynamic> _$BalanceListToJson(BalanceList instance) =>
    <String, dynamic>{
      'content': instance.content,
      'money': instance.money,
      'time': instance.time,
    };
