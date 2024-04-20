import 'package:flutter/material.dart';
import 'package:VMeste/core/constants/app_constants.dart';
import 'package:VMeste/providers/screen_index_provider.dart';
import 'package:VMeste/ui/views/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:VMeste/ui/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const VMesteApp());
}

class VMesteApp extends StatefulWidget {
  const VMesteApp({super.key});

  @override
  State<VMesteApp> createState() => _VMesteAppState();
}

class _VMesteAppState extends State<VMesteApp> {
  final _router = AppRouter();
  // ignore: unused_field

  @override
  void initState() {
    super.initState();
    //initUniLinks();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Merlin',
  //     initialRoute: RouteNames.authView,
  //     routes: _router.routes,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ScreenIndexProvider())],
      child: MaterialApp(
        theme: lightTheme,
        home: HomeScreen(),
        initialRoute: RouteNames.authView,
        debugShowCheckedModeBanner: false,
        routes: _router.routes,
      ),
    );
  }
}
