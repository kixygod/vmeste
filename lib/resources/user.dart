import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String lastName;
  final int age;
  final int commonTagsCount;
  final ImageProvider avatar;

  User({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.commonTagsCount,
    required this.avatar,
  });
}
