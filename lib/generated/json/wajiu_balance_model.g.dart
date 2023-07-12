import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/wajiu_balance_model.dart';
import 'package:json_annotation/json_annotation.dart';


WajiuBalanceModel $WajiuBalanceModelFromJson(Map<String, dynamic> json) {
	final WajiuBalanceModel wajiuBalanceModel = WajiuBalanceModel();
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		wajiuBalanceModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		wajiuBalanceModel.result = result;
	}
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		wajiuBalanceModel.states = states;
	}
	return wajiuBalanceModel;
}

Map<String, dynamic> $WajiuBalanceModelToJson(WajiuBalanceModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['msg'] = entity.msg;
	data['result'] = entity.result.toJson();
	data['states'] = entity.states;
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final List<BalanceList>? balanceList = jsonConvert.convertListNotNull<BalanceList>(json['balanceList']);
	if (balanceList != null) {
		result.balanceList = balanceList;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['balanceList'] =  entity.balanceList.map((v) => v.toJson()).toList();
	return data;
}

BalanceList $BalanceListFromJson(Map<String, dynamic> json) {
	final BalanceList balanceList = BalanceList();
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		balanceList.content = content;
	}
	final String? money = jsonConvert.convert<String>(json['money']);
	if (money != null) {
		balanceList.money = money;
	}
	final String? time = jsonConvert.convert<String>(json['time']);
	if (time != null) {
		balanceList.time = time;
	}
	return balanceList;
}

Map<String, dynamic> $BalanceListToJson(BalanceList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['content'] = entity.content;
	data['money'] = entity.money;
	data['time'] = entity.time;
	return data;
}