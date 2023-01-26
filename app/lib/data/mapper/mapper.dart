import 'package:news_app/app/constants.dart';
import 'package:news_app/data/responses/responses.dart';
import 'package:news_app/domain/models/models.dart';
import 'package:news_app/app/extensions.dart';

extension NewsResponseMapper on NewsResponse? {
  NewsObject toDomain() {
    return NewsObject(
      this?.source.toDomain(),
      this?.author.orEmpty() ?? Constants.EMPTY,
      this?.title.orEmpty() ?? Constants.EMPTY,
      this?.description.orEmpty() ?? Constants.EMPTY,
      this?.url.orEmpty() ?? Constants.EMPTY,
      this?.urlToImage.orEmpty() ?? Constants.EMPTY,
      this?.publishedAt.orEmpty() ?? Constants.EMPTY,
      this?.content.orEmpty() ?? Constants.EMPTY,
    );
  }
}

extension SourceResponseMapper on SourceRes? {
  Source toDomain() {
    return Source(
      this?.id.orEmpty() ?? Constants.EMPTY,
      this?.name.orEmpty() ?? Constants.EMPTY,
    );
  }
}

extension NewsDataResponseMapper on NewsDataResponse? {
  NewsData toDomain() {
    List<NewsObject> NewsMap =
        (this?.data?.map((newsobj) => newsobj.toDomain()) ?? Iterable.empty())
            .cast<NewsObject>()
            .toList();
    var newsData = NewsData(NewsMap);
    return newsData;
  }
}
