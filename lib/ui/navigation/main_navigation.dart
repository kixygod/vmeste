import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vmeste/ui/views/register_view/register_view.dart';
import 'package:vmeste/ui/views/settings_view/settings_view.dart';
import 'package:vmeste/ui/views/settings_view/settings_view_model.dart';

abstract class RouteNames {
  static const String registerView = '/register';
  static const String settings = '/profile/settings';
}

class MainNavigation {
  Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.registerView: (context) => const RegisterView(),
    RouteNames.settings: (context) => ChangeNotifierProvider(create: (_) => SettingsViewModel(context), child: const SettingsView()),
  };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: Text('Error: Route not found'))));
  }
}
