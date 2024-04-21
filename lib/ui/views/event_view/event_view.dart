import 'package:VMeste/components/user_card.dart';
import 'package:VMeste/resources/images.dart';
import 'package:VMeste/ui/navigation/main_navigation.dart';
import 'package:VMeste/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool isDescriptionSelected = true;
  bool showDescription = true;

  final List<Map<String, dynamic>> people = [
    {
      'firstName': 'Антон',
      'age': 19,
      'lastName': "Чебуреков",
      'commonTagsCount': 7,
      'avatar': AssetImage(Images.friend),
      'onTap': '',
      'height': 120,
    },
    {
      'firstName': 'Саша',
      'age': 23,
      'lastName': "Пивоваров",
      'commonTagsCount': 5,
      'avatar': AssetImage(Images.friend),
      'onTap': '',
      'height': 120,
    },
    {
      'firstName': 'Егор',
      'age': 15,
      'lastName': "Усиков",
      'commonTagsCount': 1,
      'avatar': AssetImage(Images.friend),
      'onTap': '',
      'height': 120,
    },
    {
      'firstName': 'Мирион',
      'age': 19,
      'lastName': "Носов",
      'commonTagsCount': 7,
      'avatar': AssetImage(Images.friend),
      'onTap': '',
      'height': 120,
    },
    {
      'firstName': 'Лена',
      'age': 19,
      'lastName': "Голач",
      'commonTagsCount': 7,
      'avatar': AssetImage(Images.friend),
      'onTap': '',
      'height': 120,
    },
  ];

  void toggleDescription(bool isSelected) {
    setState(() {
      isDescriptionSelected = isSelected;
      showDescription = isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(RouteNames.homeView);
          },
        ),
        title: Text('Назад'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Image.asset(Images.orlov), // Здесь нужно указать вашу картинку
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Сергей Орлов «Переходный возраст»',
                          style: Theme.of(context).textTheme.headline1!,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Дворец зрелищ и спорта',
                          style: Theme.of(context).textTheme.headline6!,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'От 600 руб',
                          style: Theme.of(context).textTheme.headline1!,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          toggleDescription(true);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(isDescriptionSelected ? Colors.black : Colors.white),
                        ),
                        child: Text(
                          'Описание',
                          style: TextStyle(
                            color: isDescriptionSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          toggleDescription(false);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(isDescriptionSelected ? Colors.white : Colors.black),
                        ),
                        child: Text(
                          'Кто идет',
                          style: TextStyle(
                            color: isDescriptionSelected ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            if (showDescription)
              Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Всероссийский тур Сергея Орлова, одного из самых популярных независимых стендап-комиков страны. Новая сольная программа «Переходный возраст».',
                        style: Theme.of(context).textTheme.bodySmall, // Замените этот текст на ваше описание
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
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
                          child: const Text('Планирую пойти', style: TextStyle(fontSize: 14, color: AppColors.blackColor)),
                        ),
                      )
                    ],
                  ))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    final person = people[index];
                    return UserCard(
                      firstName: person['firstName'],
                      age: person['age'],
                      lastName: person['lastName'],
                      commonTagsCount: person['commonTagsCount'],
                      avatar: person['avatar'],
                      onTap: () {},
                      height: person['height'].toDouble(), // Преобразуем int в double
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EventPage(),
  ));
}
