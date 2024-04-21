import 'package:VMeste/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:VMeste/ui/widgets/profile_header_widget.dart';
import 'package:VMeste/ui/navigation/main_navigation.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () => Navigator.pushNamed(context, RouteNames.settings),
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ProfileHeaderWidget(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'У вас нет предстоящих мероприятий',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
