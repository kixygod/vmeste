import 'dart:io';

import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  String firstName = '';
  String lastName = '';
  String country = '';
  String city = '';
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  void selectImage() {
    // Код для выбора изображения с телефона
  }

  void saveSettings() {
    // Код для отправки данных на сервер
    // Ваш код для отправки имени, фамилии, страны, города и изображения на сервер
  }

  void updateFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  void updateCountry(String value) {
    country = value;
    notifyListeners();
  }

  void updateCity(String value) {
    city = value;
    notifyListeners();
  }
}
