import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vmeste/providers/screen_index_provider.dart';
import 'package:vmeste/ui/views/profile_view/profile_view.dart';
import 'package:vmeste/ui/views/screen1.dart';
import 'package:vmeste/ui/views/screen2.dart';
import 'package:vmeste/ui/views/screen3.dart';

class HomeScreen extends StatelessWidget {
  final List<dynamic> screens = [
    const Screen1(),
    const Screen2(),
    const Screen3(),
    const ProfileView(),
  ];

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenindexprovider = Provider.of<ScreenIndexProvider>(context);
    int currentScreenIndex = screenindexprovider.fetchCurrentScreenIndex;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        elevation: 1.5,
        currentIndex: currentScreenIndex,
        onTap: (value) => screenindexprovider.updateScreenIndex(value),
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: Icon((currentScreenIndex == 0) ? Icons.home : Icons.home_outlined),
              backgroundColor: Colors.indigo // provide color to any one icon as it will overwrite the whole bottombar's color ( if provided any )
              ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon((currentScreenIndex == 1) ? Icons.search : Icons.search_outlined),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon((currentScreenIndex == 2) ? Icons.favorite : Icons.favorite_outline),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon((currentScreenIndex == 3) ? Icons.person : Icons.person_outline),
          ),
        ],
      ),
      body: screens[currentScreenIndex],
    );
  }
}
