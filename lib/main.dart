import 'package:flutter/material.dart';
import 'package:vmeste/providers/screen_index_provider.dart';
import 'package:vmeste/ui/views/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:vmeste/ui/theme/theme.dart';
import 'package:vmeste/ui/views/profile_view/profile_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ScreenIndexProvider())],
      child: MaterialApp(
        theme: lightTheme,
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
