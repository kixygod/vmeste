import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime date;
  final int price;
  final ImageProvider image;

  Event({
    required this.title,
    required this.date,
    required this.price,
    required this.image,
  });
}
