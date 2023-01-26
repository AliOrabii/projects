import 'dart:async';
import 'dart:ffi';

import 'package:mvvm_project_1/domain/model/model.dart';
import 'package:mvvm_project_1/domain/usecase/store_details_usecase.dart';
import 'package:mvvm_project_1/presentation/base/baseviewmodel.dart';
import 'package:mvvm_project_1/presentation/common/state_renderer/state_render_impl.dart';
import 'package:mvvm_project_1/presentation/common/state_renderer/state_renderer.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final StreamController _allStreamController =
      BehaviorSubject<StoreDetailsObject>();

  final StoreDetailsUseCase _storeDetailsUseCase;
  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void dispose() {
    _allStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    _getStoreDetails();
  }

  _getStoreDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    // ignore: void_checks
    (await _storeDetailsUseCase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message))
            }, (StoreDetails) {
      inputState.add(ContentState());
      Allinputs.add(StoreDetails);
      // navigate to main screen after the login
    });
  }

  @override
  Sink get Allinputs => _allStreamController.sink;

  @override
  Stream<StoreDetailsObject> get AllOutputs =>
      _allStreamController.stream.map((StoreDetails) => StoreDetails);
}

abstract class StoreDetailsViewModelInputs {
  Sink get Allinputs;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetailsObject> get AllOutputs;
}
