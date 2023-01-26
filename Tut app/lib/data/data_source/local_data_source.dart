import 'package:mvvm_project_1/data/network/error_handler.dart';
import 'package:mvvm_project_1/data/responses/responses.dart';
import 'package:mvvm_project_1/domain/model/model.dart';

const CACHE_HOME_KEY = 'CACHE_HOME_KEY';
const CACHE_STORE_DETAILS_KEY = 'CACHE_STORE_DETAILS_KEY';
const CACHE_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails();

  Future<void> saveHomeToCache(dynamic Response, String key);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = Map();
  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(dynamic Response, String key) async {
    cacheMap[key] = CachedItem(Response);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String Itemkey) {
    cacheMap.remove(Itemkey);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExternsion on CachedItem {
  bool isValid(int expirationTimeInMills) {
    int currentTimeInMills = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMills - cacheTime < expirationTimeInMills;

    return isValid;
  }
}
