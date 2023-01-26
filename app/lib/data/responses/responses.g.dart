// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as String?
  ..totalResults = json['totalResults'] as int?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
    };

SourceRes _$SourceResFromJson(Map<String, dynamic> json) => SourceRes(
      json['id'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$SourceResToJson(SourceRes instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      json['source'] == null
          ? null
          : SourceRes.fromJson(json['source'] as Map<String, dynamic>),
      json['author'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      json['url'] as String?,
      json['urlToImage'] as String?,
      json['publishedAt'] as String?,
      json['content'] as String?,
    );

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

NewsDataResponse _$NewsDataResponseFromJson(Map<String, dynamic> json) =>
    NewsDataResponse(
      (json['articles'] as List<dynamic>?)
          ?.map((e) => NewsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as String?
      ..totalResults = json['totalResults'] as int?;

Map<String, dynamic> _$NewsDataResponseToJson(NewsDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.data,
    };
