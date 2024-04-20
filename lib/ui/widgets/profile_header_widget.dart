import 'package:flutter/material.dart';
import 'package:vmeste/resources/images.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String avatarImagePath;

  const ProfileHeaderWidget({Key? key, this.avatarImagePath = Images.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Image.asset(avatarImagePath, width: 120, height: 120),
        ), // Размеры аватарки
        const SizedBox(height: 10),
        Text('Name Surname', style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 5),
        Text('Томск', style: Theme.of(context).textTheme.bodyText1),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCounter(context, 'Мероприятия', '10', () {
              // Действие при нажатии на счетчик посещенных мероприятий
              _showEventsModalBottomSheet(context);
            }),
            _buildCounter(context, 'Друзья', '100', () {
              // Действие при нажатии на счетчик друзей
              _showFriendsModalBottomSheet(context);
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCounter(BuildContext context, String title, String count, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(imagePath),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name Surname'),
              Text(''),
            ],
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
                      backgroundImage: AssetImage(Images.person), // Вставьте изображение профиля друга
                    ),
                    title: Text('Friend $i'), // Имя друга
                    subtitle: const Text('Status'), // Статус друга, например, онлайн или оффлайн
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
