import 'package:dmiti_project/app/helper.dart';
import 'package:dmiti_project/core/default_button.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                  "Профиль",
                  style: getTheme().textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 45, right: 16),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.gray2,
                      borderRadius: BorderRadius.circular(16)),
                  width: 124,
                  height: 124,
                ),
              ),
              Container(
                width: 150,
                child: Column(
                  children: [
                    Text("UserName", style: getTheme().textTheme.bodyLarge),
                    Text("Количество решенных задач - ${Helper.counter}",
                        style: getTheme().textTheme.bodyLarge),
                    Text("Результат последней КР",
                        style: getTheme().textTheme.bodyLarge)
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 53),
          child: DefaultButton(
              info: "Настройки",
              buttonColor: AppColors.green,
              onPressedFunction: () {},
              isSettings: true),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultButton(
              info: "Статистика",
              buttonColor: AppColors.green,
              onPressedFunction: () {},
              isSettings: true),
        ),
        DefaultButton(
            info: "FAQ",
            buttonColor: AppColors.green,
            onPressedFunction: () {},
            isSettings: true),
      ]),
    );
  }
}
