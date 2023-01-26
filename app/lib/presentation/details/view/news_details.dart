import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/domain/models/models.dart';
import 'package:news_app/domain/provider/news.dart';
import 'package:news_app/presentation/resources/assets_manager.dart';
import 'package:news_app/presentation/resources/color_manager.dart';
import 'package:news_app/presentation/resources/strings_manager.dart';
import 'package:news_app/presentation/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetails extends StatelessWidget {
  News news = Get.put(News());
  @override
  Widget build(BuildContext context) {
    var title = ModalRoute.of(context)?.settings.arguments.toString();
    var obj = news.findItemBytitle(title.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actionsIconTheme: IconThemeData(color: ColorManager.primary),
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: _getNewsContent(context, obj),
    );
  }

  Widget _getNewsContent(BuildContext context, NewsObject obj) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _getImage(obj.title, obj.urlToImage),
          space(AppSize.s18),
          _getTimeAndAuthor(obj.publishedAt, obj.source!.name),
          space(AppSize.s8),
          _getTitle(context, AppStrings.alkhabar),
          _getText(
              context, obj.description.isEmpty ? obj.title : obj.description),
          space(AppSize.s4),
          _getTitle(context, AppStrings.tafasel),
          _getlink(context, obj.url),
        ],
      ),
    );
  }

  Widget _getText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText2,
      textDirection: TextDirection.rtl,
    );
  }

  Widget _getlink(BuildContext context, String link) {
    return InkWell(
      child: Text(
        link,
        style: Theme.of(context).textTheme.headline3,
        textDirection: TextDirection.rtl,
      ),
      onTap: () => launchUrlString(link),
    );
  }

  Widget space(double x) {
    return SizedBox(height: x);
  }

  Widget _getImage(
    String title,
    String imageUrl,
  ) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          width: double.infinity,
          child: Hero(
            tag: title,
            child: Container(
              height: 200,
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      ImageAssets.placeHolder,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: double.infinity,
          color: ColorManager.black.withOpacity(0.3),
          child: Text(
            title,
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }

  Widget _getTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  Widget _getTimeAndAuthor(String time, String Author) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          Author,
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 5),
        Text(
          '${DateTime.parse(time).toIso8601String()}',
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
