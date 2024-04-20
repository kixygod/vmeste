import 'package:flutter/material.dart';
import 'package:vmeste/ui/views/auth_view/auth_view.dart';
import 'package:vmeste/ui/views/register_view/register_view.dart';

abstract class RouteNames {
  static const String loaderView = '/';
  static const String authView = '/auth';
  static const String registerView = '/auth/register';
  static const String profileView = '/profile';
}

class AppRouter {
  final routes = <String, Widget Function(BuildContext)>{
    RouteNames.authView: (context) => const AuthView(),
    RouteNames.registerView: (context) => const RegisterView(),
  };
}
