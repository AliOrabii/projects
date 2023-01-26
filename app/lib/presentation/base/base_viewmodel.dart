import 'dart:async';

import 'package:news_app/presentation/common/state_render_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _streamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _streamController.sink;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  Stream<FlowState> get outState =>
      _streamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outState;
}
