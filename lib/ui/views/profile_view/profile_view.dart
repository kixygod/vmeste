import 'package:flutter/material.dart';
import 'package:vmeste/ui/views/settings_view/settings_view.dart';
import 'package:vmeste/ui/widgets/profile_header_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  final List<bool> _selectedWidgets = <bool>[true, false, false];
  final _pageController = PageController();

  void _changeSelection(int index) {
    for (int i = 0; i < _selectedWidgets.length; i++) {
      _selectedWidgets[i] = i == index;
    }
  }

  void _animateToPage(int index) {
    if (_pageController.page != index) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  @override
  void initState() {
    _changeSelection(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsView()));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: const SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ProfileHeaderWidget(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
