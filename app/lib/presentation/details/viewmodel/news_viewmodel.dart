import 'dart:async';

import 'package:get/get.dart';
import 'package:news_app/domain/models/models.dart';
import 'package:news_app/domain/provider/news.dart';
import 'package:news_app/presentation/base/base_viewmodel.dart';

class NewsViewModel extends BaseViewModel
    with NewsViewModelInputs, NewsViewModelOutputs {
  final StreamController _controller = StreamController<NewsObject>();
  News news = Get.put(News());

  String title;

  NewsViewModel(this.title);
  @override
  void start() {
    _getData();
  }

  _getData() {
    var obj = news.findItemBytitle(title.toString());
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Sink get AllInputs => _controller.sink;

  @override
  Stream<NewsObject> get AllOutPuts => _controller.stream.map((event) => event);
}

abstract class NewsViewModelInputs {
  Sink get AllInputs;
}

abstract class NewsViewModelOutputs {
  Stream<NewsObject> get AllOutPuts;
}
