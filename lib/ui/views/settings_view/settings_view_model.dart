import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsViewModel extends ChangeNotifier {
  String firstName = '';
  String lastName = '';
  String country = '';
  String city = '';
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, // Уменьшаем качество изображения для экономии памяти
    );
    if (pickedFile != null) {
      if (pickedFile.path.endsWith('.png')) {
        _selectedImage = File(pickedFile.path);
        notifyListeners();
      } else {
        // Оповещаем пользователя, что можно выбирать только PNG изображения
        // Можно использовать showDialog или другой способ оповещения
        print('Выберите PNG изображение');
      }
    }
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
