import 'package:flutter/material.dart';
import 'package:VMeste/ui/navigation/main_navigation.dart';
import 'package:VMeste/ui/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(VmesteApp());
}

class VmesteApp extends StatelessWidget {
  final mainNavigation = MainNavigation();

  VmesteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.authView,
      routes: mainNavigation.routes,
    );
  }
}
