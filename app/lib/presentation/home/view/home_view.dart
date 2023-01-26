import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:news_app/app/di.dart';
import 'package:news_app/domain/models/models.dart';
import 'package:news_app/presentation/common/state_render_impl.dart';
import 'package:news_app/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:news_app/presentation/resources/assets_manager.dart';
import 'package:news_app/presentation/resources/color_manager.dart';
import 'package:news_app/presentation/resources/routes_manager.dart';
import 'package:news_app/presentation/resources/strings_manager.dart';
import 'package:news_app/presentation/resources/values_manager.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeViewModel _viewModel = instance<homeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.title,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outState,
            builder: (context, snapshot) {
              return (snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  })) ??
                  _getContentWidget();
            },
          ),
        ),
      ),
    );
  }

  Widget _getList(List<NewsObject>? list) {
    if (list != null) {
      return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: ((context, i) => _getListTile(list[i])),
      );
    } else {
      return Container();
    }
  }

  Widget _getListTile(NewsObject item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: ListTile(
        trailing: Hero(
          tag: item.title,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: item.urlToImage.isEmpty
                ? Image.asset(
                    ImageAssets.placeHolder,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    item.urlToImage,
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        title: Text(
          item.title,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          item.author,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        onTap: () => Navigator.pushNamed(context, Routes.detailsRoute,
            arguments: item.title),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<NewsData>(
        stream: _viewModel.AllOutputs,
        builder: ((context, snapshot) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _getCarouselSlider(snapshot.data?.News.sublist(0, 4)),
              const SizedBox(
                height: 20,
              ),
              _getList(snapshot.data?.News.sublist(4)),
            ],
          );
        }));
  }

  Widget _getCarouselSlider(List<NewsObject>? itemss) {
    if (itemss != null) {
      return CarouselSlider(
        items: itemss.map((item) => _getCarouselItem(item)).toList(),
        options: CarouselOptions(
          height: AppSize.s210,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getCarouselItem(NewsObject item) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.detailsRoute,
        arguments: item.title,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: AppSize.s1_5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
            //side: BorderSide(color: Colors.transparent, width: AppSize.s1_5),
          ),
          child: Hero(
            tag: item.title,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: item.urlToImage.isEmpty
                  ? Image.asset(
                      ImageAssets.placeHolder,
                      fit: BoxFit.contain,
                    )
                  : Image.network(
                      item.urlToImage,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
