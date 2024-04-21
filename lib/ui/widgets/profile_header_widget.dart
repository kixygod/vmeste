import 'dart:convert';

import 'package:VMeste/components/event_card.dart';
import 'package:VMeste/components/user_card.dart';
import 'package:VMeste/resources/event.dart';
import 'package:VMeste/resources/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  final List<User> friends = [
    User(
      firstName: "Иван",
      lastName: "Иванов",
      age: 21,
      commonTagsCount: 3,
      avatar: const AssetImage(Images.friend),
    ),
    User(
      firstName: "Мария",
      lastName: "Смирнова",
      age: 25,
      commonTagsCount: 1,
      avatar: const AssetImage(Images.friend),
    ),
    User(
      firstName: "Алексей",
      lastName: "Кузнецов",
      age: 32,
      commonTagsCount: 5,
      avatar: const AssetImage(Images.friend),
    ),
  ];

  final events = [
    Event(
      title: 'Хакатон',
      date: DateTime(2024, 5, 20),
      price: 300,
      image: const AssetImage(Images.hackaton),
    )
  ];

  int _calculateAge(String birthday) {
    final birthDate = DateTime.parse(birthday);
    final now = DateTime.now();
    var age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

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
      if (_userData!.containsKey('friends')) {
        var newFriends = _userData!['friends'] as List<dynamic>;
        friends.addAll(newFriends.map((friend) {
          return User(
            firstName: friend['name'],
            lastName: friend['surname'],
            age: _calculateAge(friend['birthday']),
            commonTagsCount: friend['count'] ?? 0,
            avatar: AssetImage(Images.friend),
          );
        }).toList());
      }
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
            color: Colors.black.withOpacity(0.25),
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
          Text(_userData != null ? '${_userData!['name']} ${_userData!['surname']}' : 'Имя Фамилия', style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: 5),
          Text(_userData != null && _userData!['town'] != '' ? '${_userData!['town']}' : 'Томск', style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCounter(context, 'Мероприятия', '${getAttendedEventsCount(_userData)}', () {
                // Действие при нажатии на счетчик посещенных мероприятий
                _showEventsModalBottomSheet(context, events);
              }),
              _buildCounter(context, 'Друзья', '${getFriendsCount(_userData)}', () {
                // Действие при нажатии на счетчик друзей
                _showFriendsModalBottomSheet(context, friends);
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(BuildContext context, String title, String count, VoidCallback onPressed) {
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

  void _showEventsModalBottomSheet(BuildContext context, List<Event> events) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Мероприятия', // Название секции
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Padding(
                        // Обернем в Padding для отступов между элементами
                        padding: const EdgeInsets.only(bottom: 20),
                        child: EventCard(
                          title: event.title,
                          date: event.date,
                          price: event.price,
                          image: event.image,
                          onTap: () {
                            print('Выбрано событие "${event.title}"');
                          },
                          height: 160,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFriendsModalBottomSheet(BuildContext context, List<User> friends) {
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Друзья',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: UserCard(
                          firstName: friend.firstName,
                          lastName: friend.lastName,
                          age: friend.age,
                          commonTagsCount: friend.commonTagsCount,
                          avatar: friend.avatar,
                          onTap: () {
                            // Логика перехода на страницу пользователя
                            print('Перейти к профилю ${friend.firstName} ${friend.lastName}');
                          },
                          height: 120,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
