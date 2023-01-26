import 'dart:async';
import 'dart:ffi';

import 'package:mvvm_project_1/domain/model/model.dart';
import 'package:mvvm_project_1/domain/usecase/home_usecase.dart';
import 'package:mvvm_project_1/presentation/base/baseviewmodel.dart';
import 'package:mvvm_project_1/presentation/common/state_renderer/state_render_impl.dart';
import 'package:mvvm_project_1/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _AllStreamController = BehaviorSubject<HomeData>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    // ignore: void_checks
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message))
            }, (home) {
      inputState.add(ContentState());
      Allinputs.add(home.data);

      // navigate to main screen after the login
    });
  }

  @override
  void dispose() {
    _AllStreamController.close();
    super.dispose();
  }

  @override
  Stream<HomeData> get AllOutputs =>
      _AllStreamController.stream.map((data) => data);

  @override
  Sink get Allinputs => _AllStreamController.sink;

  //  *INPUTS

  // *OUTPUTS

}

abstract class HomeViewModelInput {
  Sink get Allinputs;
}

abstract class HomeViewModelOutput {
  Stream<HomeData> get AllOutputs;
}
