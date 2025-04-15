// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SocialMediaLink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialMediaLink _$SocialMediaLinkFromJson(Map<String, dynamic> json) =>
    SocialMediaLink(
      json['platform'] as String,
      json['url'] as String,
      json['iconUrl'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$SocialMediaLinkToJson(SocialMediaLink instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'url': instance.url,
      'iconUrl': instance.iconUrl,
      'name': instance.name,
    };
