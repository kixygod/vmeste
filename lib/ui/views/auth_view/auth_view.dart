import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:VMeste/ui/theme/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:VMeste/ui/navigation/main_navigation.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  AuthViewState createState() => AuthViewState();
}

class AuthViewState extends State<AuthView> {
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
              Text('Авторизация', style: TextStyle(fontSize: 32, color: AppColors.black)),
              const SizedBox(height: 64),
              TextField(
                controller: loginController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: AppColors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.darkPurple),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Логин'),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: AppColors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.darkPurple),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Пароль'),
              ),
              const SizedBox(height: 64),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.green,
                    padding: const EdgeInsets.all(16.0),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                    if (loginController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Заполните поле логина');
                    } else if (passwordController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Заполните поле пароля');
                    } else if (passwordController.text.length < 8) {
                      Fluttertoast.showToast(msg: 'Минимальная длина пароля 8 символов');
                    } else {
                      auth(loginController.text, passwordController.text);
                    }
                  },
                  child: Text('Войти', style: Theme.of(context).textTheme.bodyText1)),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.registerView);
                  },
                  child: Text('Регистрация', style: Theme.of(context).textTheme.bodyText1))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> auth(String login, String password) async {
    final Map<String, dynamic> data = {"login": login, "password": password};
    final url = Uri.parse('${dotenv.get('API_HOST')}/user/sign/in');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'] as String;

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      print('Token: $token');
      Navigator.pushReplacementNamed(context, RouteNames.homeView);
    } else {
      print('Ошибка при отправке данных');
      Fluttertoast.showToast(msg: 'Неверные данные');
    }
  }
}
