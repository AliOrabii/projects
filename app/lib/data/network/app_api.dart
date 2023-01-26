import 'package:dio/dio.dart';
import 'package:news_app/app/constants.dart';
import 'package:news_app/data/responses/responses.dart';
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET('')
  Future<NewsDataResponse> getData();
}
