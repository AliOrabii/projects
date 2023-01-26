import 'package:news_app/data/network/app_api.dart';
import 'package:news_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<NewsDataResponse> getData();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<NewsDataResponse> getData() async {
    return await _appServiceClient.getData();
  }
}
