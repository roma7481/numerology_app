import 'package:json_annotation/json_annotation.dart';

part 'SocialMediaLink.g.dart';

@JsonSerializable()
class SocialMediaLink {
  final String platform;
  final String url;
  final String iconUrl;
  final String name;

  SocialMediaLink(this.platform, this.url, this.iconUrl, this.name);

  factory SocialMediaLink.fromJson(String platform, Map<String, dynamic> json) =>
      SocialMediaLink(
        platform,
        json['url'] as String,
        json['icon'] as String,
        json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
    'url': url,
    'icon': iconUrl,
    'name': name,
  };
}