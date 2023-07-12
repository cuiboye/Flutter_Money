import 'package:flutter_money/generated/json/base/json_convert_content.dart';
import 'package:flutter_money/http/user.dart';
import 'package:json_annotation/json_annotation.dart';


User $UserFromJson(Map<String, dynamic> json) {
	final User user = User();
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		user.icon = icon;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		user.title = title;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		user.url = url;
	}
	final String? statusBarColor = jsonConvert.convert<String>(json['statusBarColor']);
	if (statusBarColor != null) {
		user.statusBarColor = statusBarColor;
	}
	final bool? hideAppBar = jsonConvert.convert<bool>(json['hideAppBar']);
	if (hideAppBar != null) {
		user.hideAppBar = hideAppBar;
	}
	return user;
}

Map<String, dynamic> $UserToJson(User entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['icon'] = entity.icon;
	data['title'] = entity.title;
	data['url'] = entity.url;
	data['statusBarColor'] = entity.statusBarColor;
	data['hideAppBar'] = entity.hideAppBar;
	return data;
}