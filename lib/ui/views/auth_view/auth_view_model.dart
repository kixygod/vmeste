import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthViewModel extends ChangeNotifier {
  String login = '';
  String password = '';

  Future<void> sendLoginPassword(String login, String password) async {
    // код для отправки данных на сервер
    final Map<String, dynamic> data = {
      "login": login,
      "password": password
    };
    final url = Uri.parse('${dotenv.get('API_HOST')}/user/sign/in');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print('200');
    }
    if (response.statusCode == 201) {
      print('201');
    } else {
      print('Ошибка при отправке данных');
    }
  }
}