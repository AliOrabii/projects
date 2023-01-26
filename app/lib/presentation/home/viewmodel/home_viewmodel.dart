import 'dart:async';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:news_app/data/network/failure.dart';
import 'package:news_app/domain/models/models.dart';
import 'package:news_app/domain/provider/news.dart';
import 'package:news_app/domain/usecase/news_usecase.dart';
import 'package:news_app/presentation/base/base_viewmodel.dart';
import 'package:news_app/presentation/common/state_render.dart';
import 'package:news_app/presentation/common/state_render_impl.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:rxdart/rxdart.dart';

class homeViewModel extends BaseViewModel
    implements homeViewModelInput, homeViewModelOutputs {
  final StreamController _controller = BehaviorSubject<NewsData>();
  final NewsUseCase _newsUseCase;

  homeViewModel(this._newsUseCase);
  final news = Get.put(News());

  @override
  void start() {
    _getNews();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Sink get AllInputs => _controller.sink;

  @override
  Stream<NewsData> get AllOutputs =>
      _controller.stream.map((Newsdata) => Newsdata);

  _getNews() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _newsUseCase.execute(Void)).fold(
      (failure) => {
        inputState.add(
            ErrorState(StateRendererType.FULL_SCREEN_ERROR_STATE, failure.code))
      },
      (newsdata) {
        inputState.add(ContentState());
        news.addNews(newsdata.News);
        AllInputs.add(newsdata);
      },
    );
  }
}

abstract class homeViewModelInput {
  Sink get AllInputs;
}

abstract class homeViewModelOutputs {
  Stream<NewsData> get AllOutputs;
}
