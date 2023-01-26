// import 'package:flutter/material.dart';
// import 'package:news_app/app/di.dart';
// import 'package:news_app/presentation/details/view/news_details.dart';
// import 'package:news_app/presentation/home/view/home_view.dart';
// import 'package:news_app/presentation/resources/strings_manager.dart';
// import 'package:news_app/presentation/splash/view/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String detailsRoute = "/details";
}

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case Routes.detailsRoute:
//         return MaterialPageRoute(
//             settings: routeSettings, builder: (_) => NewsDetails());
//       case Routes.splashRoute:
//         return MaterialPageRoute(builder: (_) => SplashScreen());
//       case Routes.homeRoute:
//         initHomeModule();
//         return MaterialPageRoute(builder: (_) => HomeView());
//       default:
//         return unDefinedRoute();
//     }
//   }

//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//         builder: (_) => Scaffold(
//               appBar: AppBar(
//                 title: Text(AppStrings.noRouteFound),
//               ),
//               body: Center(child: Text(AppStrings.noRouteFound)),
//             ));
//   }
// }
