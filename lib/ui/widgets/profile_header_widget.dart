import 'package:flutter/material.dart';

import 'package:vmeste/resources/images.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget({super.key});

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {

  @override
  Widget build(BuildContext context) {
    const imagePath = Images.person;

    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name Surname'),
              Text(''),
            ],
          ),
        ],
      ),
    );
  }
}
