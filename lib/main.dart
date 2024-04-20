import 'package:flutter/material.dart';
import 'package:vmeste/ui/navigation/main_navigation.dart';
import 'package:vmeste/ui/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(VmesteApp());
}

class VmesteApp extends StatelessWidget {
  final mainNavigation = MainNavigation();

  VmesteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.homeView,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      routes: mainNavigation.routes,
    );
  }
}
