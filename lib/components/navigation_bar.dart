import 'package:flutter/material.dart';
import 'package:VMeste/ui/theme/colors.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      currentIndex: currentIndex,
      onTap: onTap,
      iconSize: 30,
      selectedIconTheme: IconThemeData(color: AppColors.darkPurple, size: 35),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      items: const [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.search),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
