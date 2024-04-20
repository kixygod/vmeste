import 'package:flutter/material.dart';
import 'package:VMeste/ui/theme/colors.dart';

class AfishaView extends StatelessWidget {
  const AfishaView({super.key});

  @override
  Widget build(BuildContext context) {
    String name = 'Пупа';
    String eventTitle = 'Название';
    String date = '5 янв 16:30';
    int price = 600;

    return Scaffold(
      backgroundColor: AppColors.purple,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.fiber_new_rounded,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
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
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ПОПУЛЯРНОЕ",
                            style: TextStyle(fontSize: 24),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text('Смотреть все'))
                        ],
                      ),
                      SizedBox(
                        height: 190.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 290.0,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                        height: 100, child: Text('Картинка')),
                                    const Divider(
                                      color: Colors.black,
                                      thickness: 1.0,
                                      height: 20.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          right: 20,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(eventTitle),
                                              Text(date)
                                            ],
                                          ),
                                          Column(
                                            children: [Text('От $price руб.')],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "ВАМ ПОНРАВИТСЯ",
                            style: TextStyle(fontSize: 24),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text('Смотреть все'))
                        ],
                      ),
                      SizedBox(
                        height: 190.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 290.0,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                          height: 100, child: Text('Картинка')),
                                      const Divider(
                                        color: Colors.black,
                                        thickness: 1.0,
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            left: 20,
                                            right: 20,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(eventTitle),
                                                Text(date)
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('От $price руб.')
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
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
                          child: const Text('Найти людей со схожими итересами',
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.blackColor)),
                        ),
                      )
                    ],
                  ),
                )),
          )
        ],
      )),
    );
  }
}
