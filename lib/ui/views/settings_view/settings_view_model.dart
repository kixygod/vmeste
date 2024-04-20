import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

enum Gender {
  male,
  female,
}

class SettingsViewModel extends ChangeNotifier {
  String firstName = '';
  String lastName = '';
  String city = '';
  String birthDate = '';
  Gender? _gender;
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  Gender? get gender => _gender;

  final ImagePicker _picker = ImagePicker();

  Future<void> selectImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, // Уменьшаем качество изображения для экономии памяти
    );
    if (pickedFile != null) {
      final allowedExtensions = ['.png', '.jpg', '.jpeg'];
      final isAllowedExtension = allowedExtensions.any((ext) => pickedFile.path.toLowerCase().endsWith(ext));
      if (isAllowedExtension) {
        _selectedImage = File(pickedFile.path);
        // TODO
        // if (_selectedImage!.path.isNotEmpty) {
        //   updateImageOnServer(_selectedImage!);
        // }
        notifyListeners();
      } else {
        Fluttertoast.showToast(
          msg: 'Выберите изображение формата png, jpg или jpeg',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.black,
        );
      }
    }
  }

  void saveSettings() {
    // Код для отправки данных на сервер
    // Ваш код для отправки имени, фамилии, страны, города и изображения на сервер
  }

  void updateCity(String value) {
    city = value;
    notifyListeners();
  }

  void updateBirthDate(String value) {
    birthDate = value;
    notifyListeners();
  }

  void updateGender(Gender? value) {
    _gender = value;
    notifyListeners();
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return token;
  }

  Future<void> updateImageOnServer(File image) async {
    final token = await getToken();
    if (token.isNotEmpty || token != '') {
      final url = Uri.parse('${dotenv.get('API_HOST')}/user/me');
      Future<void> updateImageOnServer(File image) async {
        final token = await getToken();
        if (token.isNotEmpty || token != '') {
          final url = Uri.parse('${dotenv.get('API_HOST')}/user/me');
          final request = http.MultipartRequest('PUT', url);
          request.headers['Authorization'] = 'Bearer $token';
          request.files.add(await http.MultipartFile.fromPath('image', image.path));
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);
          print(response);
        }
      }
    }
  }
}
