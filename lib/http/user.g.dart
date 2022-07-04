// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['icon'] as String,
      json['title'] as String,
      json['url'] as String,
      json['statusBarColor'] as String,
      json['hideAppBar'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'icon': instance.icon,
      'title': instance.title,
      'url': instance.url,
      'statusBarColor': instance.statusBarColor,
      'hideAppBar': instance.hideAppBar,
    };
