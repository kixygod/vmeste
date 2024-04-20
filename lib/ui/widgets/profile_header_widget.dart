import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:VMeste/resources/images.dart';
import 'package:http/http.dart' as http;

class ProfileHeaderWidget extends StatefulWidget {
  final String avatarImagePath;

  const ProfileHeaderWidget({super.key, this.avatarImagePath = Images.person});

  @override
  _ProfileHeaderWidgetState createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  late String _token;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await getToken();
      if (token.isNotEmpty || token != '') {
        _token = token;
        await getUserInfo();
        print(token);
      }
    });
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return token;
  }

  Future<void> getUserInfo() async {
    final url = Uri.parse('${dotenv.get('API_HOST')}/user/me');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $_token'},
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      _userData = Map<String, dynamic>.from(jsonResponse);
      print('${_userData!['name']} ${_userData!['surname']}');
      setState(() {});
      print(_userData);
    } else {
      print('Error getting user info');
    }
  }

  int getFriendsCount(Map? userData) {
    if (userData != null && userData.containsKey('friends')) {
      return (userData['friends'] as List?)?.length ?? 0;
    } else {
      return 0;
    }
  }

  int getAttendedEventsCount(Map? userData) {
    if (userData != null && userData.containsKey('attendedEvents')) {
      return (userData['attendedEvents'] as List?)?.length ?? 0;
    } else {
      return 0;
    }
  }

  String getAvatarLink(Map? userData) {
    if (userData != null && userData.containsKey('avatar')) {
      var avatar = userData['avatar'];
      if (avatar != null && avatar is String && avatar.isNotEmpty) {
        return avatar;
      }
    }
    return Images.person;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(minHeight: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ClipOval(
            child: _userData != null
                ? Image.network(
                    getAvatarLink(_userData),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    Images.person,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
          ),
          // Размеры аватарки
          const SizedBox(height: 10),
          Text(
              _userData != null
                  ? '${_userData!['name']} ${_userData!['surname']}'
                  : 'Имя Фамилия',
              style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 5),
          Text(
              _userData != null && _userData!['town'] != ''
                  ? '${_userData!['town']}'
                  : 'Томск',
              style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCounter(context, 'Мероприятия',
                  '${getAttendedEventsCount(_userData)}', () {
                // Действие при нажатии на счетчик посещенных мероприятий
                _showEventsModalBottomSheet(context);
              }),
              _buildCounter(context, 'Друзья', '${getFriendsCount(_userData)}',
                  () {
                // Действие при нажатии на счетчик друзей
                _showFriendsModalBottomSheet(context);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context, String title, String count,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _showEventsModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Здесь вы можете добавить элементы вашего списка мероприятий
              for (int i = 0; i < 20; i++)
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.grey.shade200,
                  child: Center(child: Text('Event $i')),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showFriendsModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Здесь вы можете добавить элементы вашего списка друзей
              for (int i = 0; i < 20; i++)
                Container(
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.grey.shade200,
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          Images.person), // Вставьте изображение профиля друга
                    ),
                    title: Text('Friend $i'), // Имя друга
                    subtitle: const Text(
                        'Status'), // Статус друга, например, онлайн или оффлайн
                    onTap: () {
                      // Действие при нажатии на профиль друга
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
