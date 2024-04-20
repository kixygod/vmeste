import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:VMeste/ui/views/settings_view/settings_view.dart';
import 'package:VMeste/ui/views/settings_view/settings_view_model.dart';
import 'package:VMeste/ui/widgets/profile_header_widget.dart';
import 'package:vmeste/ui/navigation/main_navigation.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
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
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
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
