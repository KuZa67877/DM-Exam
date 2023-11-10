import 'package:dmiti_project/trainingScreens/continued_fraction.dart';
import 'package:flutter/material.dart';

import 'EducationScreen.dart';
import 'StudyScreen.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  List<Widget> _widgets = [];
  int _current_index = 0;
  @override
  void initState() {
    _widgets = [
      const EducationScreen(), //TODO возможно не в initstate их вставлять, а просто в массив
      const StudyScreen(),
      const EducationScreen(),
      const StudyScreen(),
      const EducationScreen()
    ];
    super.initState();
  }

  void onTap(int index) {
    setState(() {
      _current_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 84,
        child: Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 250, 252, 254),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: const Color.fromARGB(255, 90, 90, 117),
              selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: _current_index == 0
                          ? const Color.fromARGB(255, 81, 177, 166)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      size: 24,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: _current_index == 1
                          ? const Color.fromARGB(255, 81, 177, 166)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.mode_edit,
                      size: 24,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: _current_index == 2
                          ? const Color.fromARGB(255, 81, 177, 166)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.playlist_add_check_outlined,
                      size: 24,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: _current_index == 3
                          ? const Color.fromARGB(255, 81, 177, 166)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 24,
                    ),
                  ),
                  label: '',
                ),
              ],
              currentIndex: _current_index,
              onTap: onTap,
            )),
      ),
      body: _widgets.elementAt(_current_index),
    );
  }
}
