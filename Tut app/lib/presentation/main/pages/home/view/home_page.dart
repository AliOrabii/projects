import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_project_1/app/di.dart';
import 'package:mvvm_project_1/domain/model/model.dart';
import 'package:mvvm_project_1/presentation/common/state_renderer/state_render_impl.dart';
import 'package:mvvm_project_1/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:mvvm_project_1/presentation/resources/color_manager.dart';
import 'package:mvvm_project_1/presentation/resources/routes_manager.dart';
import 'package:mvvm_project_1/presentation/resources/strings_manager.dart';
import 'package:mvvm_project_1/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: ((context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.start();
                }) ??
                _getContentWidget();
          }),
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeData>(
      stream: _viewModel.AllOutputs,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getBanner(snapshot.data?.banners),
            _getSection(AppStrings.services.tr()),
            _getServices(snapshot.data?.services),
            _getSection(AppStrings.stores.tr()),
            _getStores(snapshot.data?.stores),
          ],
        );
      },
    );
  }

  Widget _getBanner(List<BannerAD>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map((banner) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: AppSize.s1_5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      side: BorderSide(
                          color: ColorManager.primary, width: AppSize.s1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: Image.network(
                        banner.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          height: AppSize.s180,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _getServices(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        child: Container(
          height: AppSize.s140,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView.builder(
            itemBuilder: ((context, index) => Card(
                  elevation: AppSize.s4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: BorderSide(
                        color: ColorManager.white, width: AppSize.s1),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(
                          services[index].image,
                          fit: BoxFit.cover,
                          width: AppSize.s140,
                          height: AppSize.s100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: AppPadding.p8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            services[index].title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            itemCount: services.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores(List<Store>? stores) {
    if (stores != null) {
      return Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p12,
            right: AppPadding.p12,
            top: AppPadding.p12,
          ),
          child: Flex(
            direction: Axis.vertical,
            children: [
              GridView.count(
                crossAxisCount: AppSize.s2,
                crossAxisSpacing: AppSize.s8,
                mainAxisSpacing: AppSize.s8,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(stores.length, (index) {
                  return InkWell(
                    child: Card(
                      elevation: AppSize.s4,
                      child: Image.network(
                        stores[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () => Navigator.of(context)
                        .pushNamed(Routes.storeDetailsRoute),
                  );
                }),
              ),
            ],
          ));
    } else {
      return Container();
    }
  }
}
