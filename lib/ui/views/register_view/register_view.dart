import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vmeste/ui/theme/colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  String login = '';
  String password = '';
  late TextEditingController loginController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Регистрация', style: TextStyle(fontSize: 32, color: AppColors.black)),
              const SizedBox(height: 64),
              TextField(
                controller: loginController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Логин'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Пароль'),
              ),
              const SizedBox(height: 64),
              TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: AppColors.green, padding: const EdgeInsets.all(16.0)),
                  onPressed: () async {
                    sendLoginPassword(loginController.text, passwordController.text);
                  },
                  child: Text('Войти', style: TextStyle(fontSize: 24, color: AppColors.black))),
              TextButton(
                  onPressed: () async {
                    sendLoginPassword(loginController.text, passwordController.text);
                  },
                  child: Text('Регистрация', style: Theme.of(context).textTheme.bodyText1))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendLoginPassword(String login, String password) async {
    // код для отправки данных на сервер
    final Map<String, dynamic> data = {"login": login, "password": password};
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
