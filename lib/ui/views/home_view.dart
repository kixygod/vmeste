import 'package:flutter/material.dart';
import 'package:vmeste/components/navigation_bar.dart';
import 'package:vmeste/ui/views/auth_view/auth_view.dart';
import 'package:vmeste/ui/views/profile_view/profile_view.dart';
import 'package:vmeste/ui/views/screen2.dart';
import 'package:vmeste/ui/views/screen3.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<HomeView> {
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
