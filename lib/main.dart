import 'package:flutter/material.dart';
import 'package:vmeste/components/navigation_bar.dart';
import 'package:vmeste/ui/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vmeste/ui/views/auth_view/auth_view.dart';
import 'package:vmeste/ui/views/profile_view/profile_view.dart';
import 'package:vmeste/ui/views/screen2.dart';
import 'package:vmeste/ui/views/screen3.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const VMesteApp());
}

class VmesteApp extends StatelessWidget {
  const VmesteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AppPage(),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          AuthView(),
          Screen2(),
          Screen3(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
