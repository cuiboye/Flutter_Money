import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/wajiu/model/login_model.dart';
import 'package:json_annotation/json_annotation.dart';


LoginModel $LoginModelFromJson(Map<String, dynamic> json) {
	final LoginModel loginModel = LoginModel();
	final int? states = jsonConvert.convert<int>(json['states']);
	if (states != null) {
		loginModel.states = states;
	}
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		loginModel.msg = msg;
	}
	final Result? result = jsonConvert.convert<Result>(json['result']);
	if (result != null) {
		loginModel.result = result;
	}
	return loginModel;
}

Map<String, dynamic> $LoginModelToJson(LoginModel entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['states'] = entity.states;
	data['msg'] = entity.msg;
	data['result'] = entity.result?.toJson();
	return data;
}

Result $ResultFromJson(Map<String, dynamic> json) {
	final Result result = Result();
	final String? area = jsonConvert.convert<String>(json['area']);
	if (area != null) {
		result.area = area;
	}
	final int? isAlreadyBuy = jsonConvert.convert<int>(json['isAlreadyBuy']);
	if (isAlreadyBuy != null) {
		result.isAlreadyBuy = isAlreadyBuy;
	}
	final bool? invalidUser = jsonConvert.convert<bool>(json['invalidUser']);
	if (invalidUser != null) {
		result.invalidUser = invalidUser;
	}
	final String? grade = jsonConvert.convert<String>(json['grade']);
	if (grade != null) {
		result.grade = grade;
	}
	final Admin? admin = jsonConvert.convert<Admin>(json['admin']);
	if (admin != null) {
		result.admin = admin;
	}
	final bool? frozenUser = jsonConvert.convert<bool>(json['frozenUser']);
	if (frozenUser != null) {
		result.frozenUser = frozenUser;
	}
	final Fguser? fguser = jsonConvert.convert<Fguser>(json['fguser']);
	if (fguser != null) {
		result.fguser = fguser;
	}
	final bool? accountReActive = jsonConvert.convert<bool>(json['accountReActive']);
	if (accountReActive != null) {
		result.accountReActive = accountReActive;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		result.token = token;
	}
	return result;
}

Map<String, dynamic> $ResultToJson(Result entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['area'] = entity.area;
	data['isAlreadyBuy'] = entity.isAlreadyBuy;
	data['invalidUser'] = entity.invalidUser;
	data['grade'] = entity.grade;
	data['admin'] = entity.admin.toJson();
	data['frozenUser'] = entity.frozenUser;
	data['fguser'] = entity.fguser.toJson();
	data['accountReActive'] = entity.accountReActive;
	data['token'] = entity.token;
	return data;
}

Admin $AdminFromJson(Map<String, dynamic> json) {
	final Admin admin = Admin();
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		admin.username = username;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		admin.phone = phone;
	}
	return admin;
}

Map<String, dynamic> $AdminToJson(Admin entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['username'] = entity.username;
	data['phone'] = entity.phone;
	return data;
}

Fguser $FguserFromJson(Map<String, dynamic> json) {
	final Fguser fguser = Fguser();
	final int? recentTime = jsonConvert.convert<int>(json['recentTime']);
	if (recentTime != null) {
		fguser.recentTime = recentTime;
	}
	return fguser;
}

Map<String, dynamic> $FguserToJson(Fguser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['recentTime'] = entity.recentTime;
	return data;
}

UserLinkManage $UserLinkManageFromJson(Map<String, dynamic> json) {
	final UserLinkManage userLinkManage = UserLinkManage();
	final String? enter = jsonConvert.convert<String>(json['enter']);
	if (enter != null) {
		userLinkManage.enter = enter;
	}
	return userLinkManage;
}

Map<String, dynamic> $UserLinkManageToJson(UserLinkManage entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['enter'] = entity.enter;
	return data;
}