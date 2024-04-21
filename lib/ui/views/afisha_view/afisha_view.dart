import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:VMeste/resources/images.dart';
import 'package:VMeste/ui/theme/colors.dart';

class AfishaView extends StatefulWidget {
  const AfishaView({Key? key}) : super(key: key);

  @override
  State<AfishaView> createState() => _AfishaViewState();
}

class _AfishaViewState extends State<AfishaView> {
  late String _token;
  Map<String, dynamic>? _userData;
  final List<Map<String, dynamic>> _popularEvents = [
    {
      'title': 'Lida',
      'place': 'Чт, 23 мая, 19:00 · Face Club',
      'price': 1600,
      'image': Images.lida,
    },
    {
      'title': 'Лебединое озеро',
      'place': '9 июля, 19:00 · Томская филармония',
      'price': 1400,
      'image': Images.ozero,
    },
    {'title': 'Другая жизнь', 'place': 'Чт, 23 мая, 19:00 · Томский драматический театр', 'price': 1200, 'image': Images.drygaya},
  ];
  final List<Map<String, dynamic>> _recommendedEvents = [
    {
      'title': 'Сергей Орлов «Переходный возраст»',
      'place': '25 мая в 19:00, Дворец зрелищ и спорта',
      'price': 2000,
      'image': Images.orlov,
    },
    {
      'title': 'Не майся! Улыбайся. Эстус',
      'place': '28 мая в 19:00, Центр культуры ТГУ',
      'price': 300,
      'image': Images.ylabasya,
    },
  ];
  final List<Map<String, dynamic>> _onlineEvents = [
    {
      'title': 'Виртуальные экскурсии по Москве',
      'place': 'Онлайн',
      'price': 0,
      'image': Images.moskva,
    },
    {
      'title': 'Онлайн-лекции «Открытой гостиной»',
      'place': 'Онлайн',
      'price': 0,
      'image': Images.open,
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await getToken();
      if (token.isNotEmpty) {
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
    try {
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
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(Images.logo),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
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
                    children: [
                      buildEventList("ПОПУЛЯРНОЕ", _popularEvents),
                      buildEventList("ВАМ ПОНРАВИТСЯ", _recommendedEvents),
                      buildEventList("ОНЛАЙН", _onlineEvents),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Найти людей со схожими интересами',
                            style: TextStyle(fontSize: 14, color: AppColors.blackColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventList(String title, List<Map<String, dynamic>> events) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline1!,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Смотреть все',
                style: Theme.of(context).textTheme.bodyText2!,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 190.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return SizedBox(
                width: 290.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.black, width: 1.0),
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 90,
                        width: double.infinity,
                        child: Image.asset(
                          event['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title'],
                              style: Theme.of(context).textTheme.subtitle1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              event['place'],
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'От ${event['price']} руб.',
                              maxLines: 1,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
