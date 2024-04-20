import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vmeste/ui/theme/colors.dart';
import 'package:vmeste/ui/views/homescreen.dart';
import 'package:vmeste/ui/views/register_view/register_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Логин'),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Пароль'),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
                  },
                  child: Text('Регистрация', style: Theme.of(context).textTheme.bodyText1))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> auth(String login, String password) async {
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
      // Navigator.pop(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      Fluttertoast.showToast(msg: 'ПЕРЕХОД НА ЭКРАН ГДЕ ЕСТЬ ВНИЗУ КНОПОЧКИ');
    } else if (response.statusCode == 201) {
      print('201');
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      Fluttertoast.showToast(msg: 'ПЕРЕХОД НА ЭКРАН ГДЕ ЕСТЬ ВНИЗУ КНОПОЧКИ');
    } else {
      print('Ошибка при отправке данных');
      Fluttertoast.showToast(msg: 'Неверные данные');
    }
  }
}
