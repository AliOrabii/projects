import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_project_1/app/app_prefs.dart';
import 'package:mvvm_project_1/app/di.dart';
import 'package:mvvm_project_1/data/data_source/local_data_source.dart';
import 'package:mvvm_project_1/presentation/resources/assets_manager.dart';
import 'package:mvvm_project_1/presentation/resources/language_manager.dart';
import 'package:mvvm_project_1/presentation/resources/routes_manager.dart';
import 'package:mvvm_project_1/presentation/resources/strings_manager.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _getListTile(
          ImageAssets.changeLangIc,
          AppStrings.changeLanguage.tr(),
          ontap: _changeLanguage,
        ),
        const Divider(),
        _getListTile(
          ImageAssets.contactUsIc,
          AppStrings.contactUs.tr(),
          ontap: () {},
        ),
        const Divider(),
        _getListTile(
          ImageAssets.inviteFriendsIc,
          AppStrings.inviteFreinds.tr(),
          ontap: () {},
        ),
        const Divider(),
        _getListTile(
          ImageAssets.logoutIc,
          AppStrings.logout.tr(),
          ontap: () {},
        ),
      ],
    );
  }

  Widget _getListTile(String leading, String title, {Function()? ontap}) {
    return ListTile(
      leading: SvgPicture.asset(leading),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
        child: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
      ),
      onTap: ontap,
    );
  }

  _changeLanguage() {
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCALE;
  }

  _contactUs() {
    //
  }
  _inviteFriends() {
    // share app name to friends
  }
  _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}
