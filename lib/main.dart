import 'package:flutter/material.dart';
import 'package:vmeste/core/constants/app_constants.dart';
import 'package:vmeste/providers/screen_index_provider.dart';
import 'package:vmeste/ui/views/auth_view/auth_view.dart';
import 'package:vmeste/ui/views/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:vmeste/ui/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const VmesteApp());
}

class VmesteApp extends StatefulWidget {
  const VmesteApp({super.key});

  @override
  State<VmesteApp> createState() => _VmesteAppState();
}

class _VmesteAppState extends State<VmesteApp> {
  final _router = AppRouter();
  // ignore: unused_field

  @override
  void initState() {
    super.initState();
    //initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Merlin',
      initialRoute: RouteNames.authView,
      routes: _router.routes,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MultiProvider(
  //     providers: [ChangeNotifierProvider(create: (context) => ScreenIndexProvider())],
  //     child: MaterialApp(
  //       theme: lightTheme,
  //       home: HomeScreen(),
  //       initialRoute: RouteNames.authView,
  //       debugShowCheckedModeBanner: false,
  //     ),
  //   );
  // }
}
// семь мастурбеков ьегали по полю и двапжды прыгнули в канаву? когда третья мать пятой ноги вышла в окно и после этого я не хочу больше жить ведь я еблан? )