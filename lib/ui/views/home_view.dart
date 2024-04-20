import 'package:VMeste/ui/views/news_view/news_view.dart';
import 'package:flutter/material.dart';
import 'package:VMeste/components/navigation_bar.dart';
import 'package:VMeste/ui/views/auth_view/auth_view.dart';
import 'package:VMeste/ui/views/profile_view/profile_view.dart';
import 'package:VMeste/ui/views/screen2.dart';
import 'package:VMeste/ui/views/screen3.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<HomeView> {
  int _selectedIndex = 0;
  String? token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const NewsView(),
          const Screen2(),
          const Screen3(),
          token != null ? const ProfileView() : const AuthView(),
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
