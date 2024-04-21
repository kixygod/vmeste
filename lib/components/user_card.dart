import 'package:VMeste/ui/theme/colors.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final int age;
  final int commonTagsCount;
  final ImageProvider avatar;
  final Function() onTap;
  final double? height;

  const UserCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.commonTagsCount,
    required this.avatar,
    required this.onTap,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Определяем правильное склонение слова "тег"
    String tagText = commonTagsCount == 1
        ? "общий тег"
        : (commonTagsCount >= 2 && commonTagsCount <= 4)
            ? "общих тега"
            : "общих тегов";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15), // Скругление краев
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Аватарка занимает всю ширину между левой границей и вертикальной чертой
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: SizedBox(
                height: height,
                child: Image(
                  image: avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Вертикальная черта
            Container(
              width: 1,
              color: AppColors.hintColor,
              height: double.infinity, // Заставляет черту касаться обоих краев
            ),
            // Пространство для имени, возраста и тегов
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20), // Отступ сверху
                      child: Text(
                        '$firstName $lastName',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Возраст: $age'),
                    const SizedBox(height: 7),
                    Text('$commonTagsCount $tagText'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
