import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:VMeste/ui/theme/colors.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  late bool isMale = true;
  late DateTime selectedDate = DateTime.now();
  late TextEditingController loginController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController surnameController;

  @override
  void initState() {
    super.initState();
    loginController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    surnameController = TextEditingController();
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
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Пароль'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Имя'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: surnameController,
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Фамилия'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    icon: Icon(Icons.male, color: isMale ? Colors.blue : Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    icon: Icon(Icons.female, color: isMale ? Colors.grey : Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Text(
                  'Выберите дату рождения: ${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
                  style: TextStyle(fontSize: 16),
                ),
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
                    } else if (nameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Заполните поле имя');
                    } else if (surnameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Заполните поле фамилии');
                    } else if ((DateTime.now().difference(selectedDate).inDays / 365).floor() <= 10) {
                      Fluttertoast.showToast(msg: 'Минимальный допустим возраст 10 лет');
                    } else {
                      register(loginController.text, passwordController.text, nameController.text, surnameController.text, selectedDate, isMale);
                    }
                  },
                  child: Text('Зарегистрироваться', style: Theme.of(context).textTheme.bodyText1)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register(String login, String password, String name, String surname, DateTime birthday, bool sex) async {
    // код для отправки данных на сервер
    final Map<String, dynamic> data = {
      "login": login,
      "password": password,
      "name": name,
      "surname": surname,
      "birthday": DateFormat('yyyy-MM-dd').format(selectedDate),
      "sex": isMale
    };
    final url = Uri.parse('${dotenv.get('API_HOST')}/user/sign/up');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print('200');
      Fluttertoast.showToast(msg: 'Регистрация успешно завершена!');
      Navigator.pop(context);
    } else if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: 'Регистрация успешно завершена!');
      Navigator.pop(context);
    } else {
      print('Ошибка при отправке данных');
      Fluttertoast.showToast(msg: 'Ошибка');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
