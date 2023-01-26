import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/domain/models/models.dart';
import 'package:retrofit/http.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "totalResults")
  int? totalResults;
}

@JsonSerializable()
class SourceRes {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;

  // toJson
  Map<String, dynamic> toJson() => _$SourceResToJson(this);

//fromJson
  factory SourceRes.fromJson(Map<String, dynamic> json) =>
      _$SourceResFromJson(json);

  SourceRes(this.id, this.name);
}

@JsonSerializable()
class NewsResponse {
  @JsonKey(name: "source")
  SourceRes? source;
  @JsonKey(name: "author")
  String? author;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "urlToImage")
  String? urlToImage;
  @JsonKey(name: "publishedAt")
  String? publishedAt;
  @JsonKey(name: "content")
  String? content;

  // toJson
  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);

//fromJson
  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  NewsResponse(
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  );
}

@JsonSerializable()
class NewsDataResponse extends BaseResponse {
  @JsonKey(name: "articles")
  List<NewsResponse>? data;

  NewsDataResponse(this.data);

  // toJson
  Map<String, dynamic> toJson() => _$NewsDataResponseToJson(this);

//fromJson
  factory NewsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsDataResponseFromJson(json);
}
