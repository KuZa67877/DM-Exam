import 'package:dmiti_project/core/algorithms/evklid_classes.dart';
import 'package:dmiti_project/features/exam_screen/exam_screen.dart';
import 'package:dmiti_project/features/info_profile.dart';
import 'package:dmiti_project/features/user_profile.dart';
import 'package:dmiti_project/res/colors.dart';
import 'package:flutter/material.dart';
import '../features/education_screen/education_screen.dart';
import '../features/study_screen/study_screen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  final List<Widget> _widgets = [
    const EducationScreen(),
    const StudyScreen(
      isEducation: true,
      title: "Тестирование",
    ),
    const StudyScreen(
      isEducation: false,
      title: "Контроль",
    ),
    const InfoProfile()
  ];
  int _currentIndex = 0;

  // void onTap(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //     if (_currentIndex == 2) {
  //       _widgets[2] = TaskScreen(
  //         tasks: [
  //           AxBy1(),
  //           NOD(),
  //           ContinuedFraction(),
  //           InverseNumber(),
  //           SuitableFractions(),
  //           Diafant()
  //         ],
  //       );
  //     }
  //   });
  // }
  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> bottomItems(List<IconData> items) =>
      List<BottomNavigationBarItem>.generate(
        4,
        (index) => BottomNavigationBarItem(
          icon: CustomNavigationBarItem(
            icon: items[index],
            currentIndex: _currentIndex,
            buttonIndex: index,
          ),
          label: '',
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 84,
        child: BottomNavigationBar(
          unselectedItemColor: AppColors.gray1,
          selectedItemColor: AppColors.white,
          items: bottomItems(const [
            Icons.info_outline,
            Icons.mode_edit,
            Icons.playlist_add_check_outlined,
            Icons.person_outline
          ]),
          currentIndex: _currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      body: _widgets.elementAt(_currentIndex),
    );
  }
}

class CustomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final int currentIndex;
  final int buttonIndex;

  const CustomNavigationBarItem({
    Key? key,
    required this.icon,
    required this.currentIndex,
    required this.buttonIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: currentIndex == buttonIndex ? AppColors.green : AppColors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Icon(
        icon,
        size: 24,
      ),
    );
  }
}
