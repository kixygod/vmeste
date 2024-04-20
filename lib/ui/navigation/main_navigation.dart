import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:VMeste/ui/views/home_view.dart';
import 'package:VMeste/ui/views/register_view/register_view.dart';
import 'package:VMeste/ui/views/settings_view/settings_view.dart';
import 'package:VMeste/ui/views/settings_view/settings_view_model.dart';

abstract class RouteNames {
  static const String homeView = '/home';
  static const String settings = '/home/settings';
  static const String registerView = '/register';
}

class MainNavigation {
  Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.homeView: (context) => const HomeView(),
    RouteNames.registerView: (context) => const RegisterView(),
    RouteNames.settings: (context) => ChangeNotifierProvider(
        create: (_) => SettingsViewModel(context), child: const SettingsView()),
  };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: Center(child: Text('Error: Route not found'))));
  }
}
