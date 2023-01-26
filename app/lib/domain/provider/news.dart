import 'package:get/get.dart';
import 'package:news_app/domain/models/models.dart';

class News extends GetxController {
  var news = <NewsObject>[].obs;

  void addNews(List<NewsObject> list) {
    news.value.addAll(list);
    update(news);
  }

  NewsObject findItemBytitle(String title) {
    return news.firstWhere((element) => element.title == title);
  }
}
