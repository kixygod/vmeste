import 'dart:convert';
import 'dart:io';

import 'package:VMeste/ui/navigation/main_navigation.dart';
import 'package:VMeste/ui/views/profile_view/profile_view.dart';
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
  String town = '';
  String contact = '';
  bool isLoading = false;
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  final ImagePicker _picker = ImagePicker();

  SettingsViewModel(BuildContext context) {
    // что тут
  }

  factory SettingsViewModel.create(BuildContext context) {
    return SettingsViewModel(context);
  }

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

  Future<void> saveSettings(BuildContext context) async {
    // Код для отправки данных на сервер
    // Ваш код для отправки имени, фамилии, страны, города и изображения на сервер
    isLoading = true;
    notifyListeners();
    // await Future.delayed(const Duration(seconds: 1));
    if (_selectedImage != null) {
      await updateImageOnServer(_selectedImage!);
    }
    if (contact.isNotEmpty || town.isNotEmpty) {
      await updateUserContactAndTown(contact, town);
    }
    isLoading = false;
    notifyListeners();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView()));
  }

  void updateTown(String value) {
    town = value;
    notifyListeners();
  }

  void updateContact(String value) {
    town = value;
    notifyListeners();
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return token;
  }

  String fileToBase64(File file) {
    List<int> bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  Future<void> updateImageOnServer(File image) async {
    final token = await getToken();
    if (token.isNotEmpty || token != '') {
      final url = Uri.parse('${dotenv.get('API_HOST')}/user/avatar');

      var request = http.MultipartRequest('PUT', url)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
        });

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));

      var streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('${response.statusCode}');
        Fluttertoast.showToast(msg: 'Изображение сохранено');
      } else {
        print('Ошибка при отправке данных: ${response.statusCode}');
        Fluttertoast.showToast(msg: 'Ошибка');
      }
    } else {
      Fluttertoast.showToast(msg: 'Токен недействителен или отсутствует');
    }
  }

  Future<void> updateUserContactAndTown(String contact, String town) async {
    final token = await getToken();
    if (token.isNotEmpty) {
      final Map<String, dynamic> data = {"contact": contact, "town": town};

      final url = Uri.parse('${dotenv.get('API_HOST')}/user');
      final response = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Данные сохранены!');
      } else {
        Fluttertoast.showToast(msg: 'Ошибка при сохранении данных: ${response.statusCode}');
      }
    } else {
      Fluttertoast.showToast(msg: 'Токен недействителен или отсутствует');
    }
  }
}
