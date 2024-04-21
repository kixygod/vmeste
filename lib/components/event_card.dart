import 'package:VMeste/ui/theme/colors.dart';
import 'package:flutter/material.dart';

String trimTitle(String title, int maxLength) {
  if (title.length > maxLength) {
    // Удаляем пробелы в конце, чтобы предотвратить пробел перед многоточием
    var trimmedTitle = title.trim();
    // Обрезаем до 20 символов и добавляем многоточие
    return trimmedTitle.substring(0, maxLength).replaceFirst(RegExp(r'\s*$'), '') + '...';
  } else {
    return title;
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final int price;
  final ImageProvider image;
  final Function() onTap;
  final double? height;

  const EventCard({
    Key? key,
    required this.title,
    required this.date,
    required this.price,
    required this.image,
    required this.onTap,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: SizedBox(
                height: height! * 2 / 3,
                width: double.infinity,
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 1,
              color: AppColors.hintColor,
              width: double.infinity,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          trimTitle(title, 16), // Используем функцию обрезания строки
                          style: Theme.of(context).textTheme.headline2,
                          overflow: TextOverflow.ellipsis, // Для корректного отображения в одном ряду
                        ),
                        Expanded(child: Container()),
                        Text(
                          'от ${price.toString()}р',
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    Text(
                      'Дата: ${date.toString()}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
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
