import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project_1/app/constant.dart';
import 'package:mvvm_project_1/app/di.dart';
import 'package:mvvm_project_1/domain/model/model.dart';
import 'package:mvvm_project_1/presentation/common/state_renderer/state_render_impl.dart';
import 'package:mvvm_project_1/presentation/resources/color_manager.dart';
import 'package:mvvm_project_1/presentation/resources/strings_manager.dart';
import 'package:mvvm_project_1/presentation/resources/values_manager.dart';
import 'package:mvvm_project_1/presentation/store_details/viewmodel/store_details_viewmodel.dart';

class StoreDetailsView extends StatefulWidget {
  @override
  _StoreDetailsViewState createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.storeDetails.tr(),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: ((context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.start();
              }) ??
              _getContentWidget();
        }),
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: StreamBuilder<StoreDetailsObject>(
        stream: _viewModel.AllOutputs,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getImage(snapshot.data),
              _getSection(AppStrings.details.tr()),
              _getText(snapshot.data?.details),
              _getSection(AppStrings.services.tr()),
              _getText(snapshot.data?.services),
              _getSection(AppStrings.about.tr()),
              _getText(snapshot.data?.about),
            ],
          );
        },
      ),
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p8,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _getImage(StoreDetailsObject? storeDetailsObject) {
    if (storeDetailsObject != null) {
      return SizedBox(
        width: double.infinity,
        height: AppSize.s200,
        child: ClipRRect(
          child: Image.network(
            storeDetailsObject.image,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getText(String? Textcontent) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p8),
      child: Flexible(
        child: Text(
          Textcontent ?? Constants.EMPTY,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
