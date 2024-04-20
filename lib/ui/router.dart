import 'package:flutter/material.dart';
import 'package:vmeste/core/constants/app_constants.dart';
import 'package:vmeste/ui/widgets/profile_header_widget.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.loaderView:
        return MaterialPageRoute(builder: (_) => const ProfileHeaderWidget());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
