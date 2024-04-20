import 'package:VMeste/ui/views/afisha_view/afisha_view.dart';
import 'package:VMeste/ui/views/map_view/map_view.dart';
import 'package:flutter/material.dart';
import 'package:VMeste/components/navigation_bar.dart';
import 'package:VMeste/ui/views/profile_view/profile_view.dart';

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
        children: const [
          AfishaView(),
          MapView(),
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
