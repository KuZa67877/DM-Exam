import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class InfoProfile extends StatefulWidget {
  const InfoProfile({super.key});

  @override
  State<InfoProfile> createState() => _InfoProfileState();
}

class _InfoProfileState extends State<InfoProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 250, 252, 254),
        title: SizedBox(
          child: Column(
            children: [
              Center(
                child: Text(
                  "О программе",
                  style: getTheme().textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Container(
              width: 300,
              child: Column(
                children: [
                  Text(
                    "Программа предназначена для поддержки самостоятельной работы по изучению алгоритмов над целыми числами по курсу Дискретной математики лектора С.Н.Позднякова.",
                    style: getTheme().textTheme.bodyLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Разработали: Дамакин Р.П. Кузьминых Е.М. Шурыгин Д.Л.",
                      style: getTheme().textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Разработано с помощью Flutter",
                        style: getTheme().textTheme.bodyLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Text("2023", style: getTheme().textTheme.bodyLarge),
                  )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
